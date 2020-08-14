#include<stdio.h>
#include<string.h>
#include<errno.h>
#include<sys/socket.h>
#include<sys/types.h>
#include<sys/ioctl.h>
#include<net/if.h>
//#include<linux/in.h>
#include<arpa/inet.h>
#include<unistd.h>
#include<linux/if_ether.h>

int main(int argc,char** argv) {
	int sock,n;
	char buffer[2048];
	unsigned char* iphead,*ethhead;
	struct ifreq ethreq;
	int no=0;//设置原始套接字方式为接收所有的数据包
	if((sock=socket(PF_PACKET,SOCK_RAW,htons(ETH_P_IP)))<0){
		perror("\n原始套接字建立失败");
		return sock;
	}//设置网卡工作方式为混杂模式，SIOCGIFFLAGS请求表示需要获取接口标志
	strncpy(ethreq.ifr_name,"eth0",IFNAMSIZ);//InterfaceNamesize
	if(ioctl(sock,SIOCGIFFLAGS,&ethreq)==-1){
		perror("\n设置混杂工作模式失败");
		close(sock);
		return -1;
	}//开始捕获数据并进行简单分析
	while(1){
		n=recvfrom(sock,buffer,2048,0,NULL,NULL);
		no++;
		printf("\n************%dpacket%dbytes************\n",no,n);
		//检查包是否包含了至少完整的以太帧（14），IP（20）和TCP/UDP（8）包头
		if(n<42){
			perror("recvfrom():");
			return n;
		}
		ethhead=(unsigned char*)buffer;
		printf("DestMACaddress:%02x:%02x:%02x:%02x:%02x:%02x\n",ethhead[0],ethhead[1],ethhead[2],ethhead[3],ethhead[4],ethhead[5]);
		printf("SourceMACaddress:%02x:%02x:%02x:%02x:%02x:%02x\n",ethhead[6],ethhead[7],ethhead[8],ethhead[9],ethhead[10],ethhead[11]);
		iphead=(unsigned char*)buffer+14;
		/*跳过Ethernetheader*/
		if(*iphead==0x45){
			/*DoublecheckforIPv4*andnooptionspresent*/
			printf("Sourcehost:%d.%d.%d.%d,",iphead[12],iphead[13],iphead[14],iphead[15]);
			printf("Desthost:%d.%d.%d.%d\n",iphead[16],iphead[17],iphead[18],iphead[19]);
			printf("Sourceport:%d,Destport:%d",(iphead[20]<<8)+iphead[21],(iphead[22]<<8)+iphead[23]);
			if(iphead[9]==6) printf("TCP\n");
			else if(iphead[9]==17) printf("UDP\n");
			else printf("protocolid:%d\n",iphead[9]);
		}
	}
}