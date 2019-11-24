 stty -echo
 echo -n Package名称：
 read Pack_name
 echo -n Package种类：
 read Pack_type
 echo -n Package描述：
 read Pack_description
 echo -n Package模块描述：
 read Pack_module_description
 echo -n Package版本：
 read Pack_version
 echo -n Package模块版本：
 read Pack_module_version
 echo -n Package最小工作版本：
 read Pack_min_engine_version
 echo -n PackageUUID：
 read Pack_uuid
 echo -n Package模块UUID：
 read Pack_module_uuid
 echo 是否含有依赖包？
 read Pack_dep
 echo -n 依赖包uuid：
 read Pack_dep_uuid
 echo -n 依赖包版本：
 read Pack_dep_version
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
manifest9=${manifest8//Pack_module_version/$Pack_module_version}
 echo $manifest9