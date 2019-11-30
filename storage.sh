----------------------------------------------------------
stty -echo
 echo -n Package名称：
stty echo
 read Pack_name
stty -echo
 echo -n Package种类：
stty echo
 read Pack_type
stty -echo
 echo -n Package描述：
stty echo
 read Pack_description
stty -echo
 echo -n Package模块描述：
stty echo
 read Pack_module_description
stty -echo
 echo -n Package版本：
stty echo
 read Pack_version
stty -echo
 echo -n Package模块版本：
stty echo
 read Pack_module_version
stty -echo
 echo -n Package最小工作版本：
stty echo
 read Pack_min_engine_version
stty -echo
 echo -n PackageUUID：
stty echo
 read Pack_uuid
stty -echo
 echo -n Package模块UUID：
stty echo
 read Pack_module_uuid
stty -echo
 echo 是否含有依赖包？
stty echo
 read Pack_dep
stty -echo
 if [ $Pack_dep = true ]
then
 echo -n 依赖包uuid：
stty echo
 read Pack_dep_uuid
stty -echo
 echo -n 依赖包版本：
stty echo
 read Pack_dep_version
stty -echo
fi
if [ $Pack_dep = false ]
then
manifest='{
   "format_version": 1,
    "header": {
      "description":"Pack_description",
      "min_engine_version":Pack_min_engine_version,
      "name":"Pack_name",
      "uuid":"Pack_uuid",
      "version":Pack_version
  },
    "modules": [
  {
      "description":"Pack_module_description",
      "type":"Pack_type",
      "uuid":"Pack_module_uuid",
      "version":Pack_module_version
    }
  ]
}'

manifest1=${manifest//Pack_description/$Pack_description}
manifest2=${manifest1//Pack_min_engine_version/$Pack_min_engine_version}
manifest3=${manifest2//Pack_name/$Pack_name}
manifest4=${manifest3//Pack_uuid/$Pack_uuid}
manifest5=${manifest4//Pack_version/$Pack_version}
manifest6=${manifest5//Pack_module_description/$Pack_module_description}
manifest7=${manifest6//Pack_type/$Pack_type}
manifest8=${manifest7//Pack_module_uuid/$Pack_module_uuid}
manifestend=${manifest8//Pack_module_version/$Pack_module_version}
else
manifest='{
   "format_version": 1,
    "header": {
      "description":"Pack_description",
      "min_engine_version":Pack_min_engine_version,
      "name":"Pack_name",
      "uuid":"Pack_uuid",
      "version":Pack_version
  },
    "modules": [
  {
      "description":"Pack_module_description",
      "type":"Pack_type",
      "uuid":"Pack_module_uuid",
      "version":Pack_module_version
    }
  ],
     "dependencies":[
    {
        "uuid":"Pack_dep_uuid",
        "version":Pack_dep_version
    }
  ]
}'
manifest1=${manifest//Pack_description/$Pack_description}
manifest2=${manifest1//Pack_min_engine_version/$Pack_min_engine_version}
manifest3=${manifest2//Pack_name/$Pack_name}
manifest4=${manifest3//Pack_uuid/$Pack_uuid}
manifest5=${manifest4//Pack_version/$Pack_version}
manifest6=${manifest5//Pack_module_description/$Pack_module_description}
manifest7=${manifest6//Pack_type/$Pack_type}
manifest8=${manifest7//Pack_module_uuid/$Pack_module_uuid}
manifest9=${manifest8//Pack_module_version/$Pack_module_version}
manifest10=${manifest9//Pack_dep_uuid/$Pack_dep_uuid}
manifestend=${manifest10//Pack_dep_version/$Pack_dep_version}

fi
 echo $manifestend > manifest.json
stty echo
-----------------------------------------------------
stty -echo
text=''
path=''
name=unname
type=end
function fun_input(){
  stty echo
  read input
  stty -echo
  input1=${input// }
  input2=${input1%%:*}
  inputed=${input1#*:}
case $input2 in
  '[name]')
  name=$inputed
  input=''
  fun_input;;
  '[path]')
  path=$input2
  input=''
  fun_input;;
  '[input]')
  type=input
  input=''
  fun_input;;
  '[end]')
  type=end
  input=''
  fun_input;;
  '[exit]')
  exit=true
  input='';;
  *)
  if [ $type = input ]
  then
    echo $input >> ${path}${name}.mcfunction
    input=''
  fi
  input=''
  fun_input
esac

 }
 ----------------------------------------------------
