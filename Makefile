define gen_protos
	protoc -I=protos --swift_out=front/ios/Slide/Protos $1.proto
	pipenv run python front/ios/proto.py $1.pb.swift
	
	protoc -I=protos --go_out=back/app/protos --go_opt=paths=source_relative $1.proto
endef

proto:
	@$(call gen_protos,"sage")
	@$(call gen_protos,"net")
