-- path: system/full_page_cache/caching_application
INSERT IGNORE INTO core_config_data (config_id,scope,scope_id,path,value) values (18,'default',0,'system/full_page_cache/caching_application',2);

-- optional, for exporting VCL file only

INSERT IGNORE INTO core_config_data (config_id,scope,scope_id,path,value) values (19,'default',0,'system/full_page_cache/varnish/access_list', 'localhost');

INSERT IGNORE INTO core_config_data (config_id,scope,scope_id,path,value) values (20,'default',0,'system/full_page_cache/varnish/backend_host', '127.0.0.1');

INSERT IGNORE INTO core_config_data (config_id,scope,scope_id,path,value) values (21,'default',0,'system/full_page_cache/varnish/backend_port', '8080');

