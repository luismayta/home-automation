#
# See ./CONTRIBUTING.rst
#
pytest.help:
	@echo '    Pytest:'
	@echo ''
	@echo '        pytest                      show help info'
	@echo '        pytest.all                  Run all pytest'
	@echo '        pytest run={module}         Run module pytest'
	@echo ''

pytest:
	@echo $(MESSAGE) Running tests on the current Python interpreter with coverage $(END)
	@if [ -z "${run}" ]; then \
		make pytest.help;\
	fi
	@if [ -n "${run}" ]; then \
		$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/test.yml run --rm app bash -c "$(PIPENV_RUN) pytest tests/${run}" \
	fi

pytest.all:
	$(docker-compose) -f ${PATH_DOCKER_COMPOSE}/test.yml run --rm app bash -c "$(PIPENV_RUN) pytest"
