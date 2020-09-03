# Ansible
.PHONY: ansible.help
USER:=ubuntu
ANSIBLE_DIR:=$(PROVISION_DIR)/ansible

ansible:
	make ansible.help

ansible.help:
	@echo '    Ansible:'
	@echo ''
	@echo '        ansible.encrypt            encrypt by stage'
	@echo '        ansible.decrypt            decrypt by stage'
	@echo '        ansible.update             Update Roles ansible by stage'
	@echo '        ansible.provision          Provision servers by stage'
	@echo '        ansible.deploy             Deploy dependences by stage'
	@echo '        ansible.tag                Deploy tag by stage'
	@echo ''

ansible.encrypt:
	@$(PIPENV_RUN) ansible-vault encrypt ${ANSIBLE_DIR}/${stage}/vars/vars.yaml \
		--vault-password-file ${KEYBASE_PROJECT_PATH}/${stage}/password/${PROJECT}-${stage}.txt && \
		echo $(MESSAGE_HAPPY)

ansible.decrypt:
	@$(PIPENV_RUN) ansible-vault decrypt ${ANSIBLE_DIR}/${stage}/vars/vars.yaml \
		--vault-password-file ${KEYBASE_PROJECT_PATH}/${stage}/password/${PROJECT}-${stage}.txt && \
		echo $(MESSAGE_HAPPY)

ansible.update:
	@$(PIPENV_RUN) ansible-galaxy install -r ${ANSIBLE_DIR}/${stage}/requirements.yml \
			   --roles-path ${ANSIBLE_DIR}/${stage}/roles/contrib --force

ansible.tag:
	@$(PIPENV_RUN) ansible-playbook -v \
			${ANSIBLE_DIR}/${stage}/deploy.yaml -i ${ANSIBLE_DIR}/${stage}/inventories/aws \
			--user=${USER} --private-key=${KEYBASE_PROJECT_PATH}/${stage}/pem/${PROJECT}-${stage}.pem \
			--tags ${tags} \
			--extra-vars @${ANSIBLE_DIR}/${stage}/vars/vars.yaml \
			--vault-password-file ${KEYBASE_PROJECT_PATH}/${stage}/password/${PROJECT}-${stage}.txt && \
			echo $(MESSAGE_HAPPY)
