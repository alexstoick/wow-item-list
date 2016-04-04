create_ca:
	sudo mkdir -p /etc/docker/certs.d/wow.stoica.xyz:5000
	sudo mv ca.crt /etc/docker/certs.d/wow.stoica.xyz:5000/ca.crt
	sudo cat /etc/docker/certs.d/wow.stoica.xyz:5000/ca.crt
	sudo service docker restart

builddocker:
		docker build -t wow_item_list_build:latest .

ID=$(shell docker images -q wow_item_list_build)

rundocker:
		docker run -d --name wow_item_list_build -it $(ID) bash

mv_item_list:
		docker cp wow_item_list_build:/go/src/github.com/alexstoick/wow-item-list/item_list build/item_list
build_item_list:
		docker build -t wow_item_list:latest build/.
tag_and_push_item_list:
		docker tag wow_item_list wow.stoica.xyz:5000/wow_item_list
		docker push wow.stoica.xyz:5000/wow_item_list

killdocker:
		docker stop wow_item_list_build
		docker rm wow_item_list_build

deploy_item_list: mv_item_list build_item_list tag_and_push_item_list

deploy: deploy_item_list
