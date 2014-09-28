update version set version_no=(SELECT version_no from version)+1 where id=1;
