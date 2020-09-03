#
# See ./CONTRIBUTING.rst
#
.PHONY: ngrok.help

ngrok.help:
	@echo '    ngrok:'
	@echo ''
	@echo '        ngrok                      help ngrok'
	@echo '        ngrok.run                  Run ngrok'
	@echo ''

ngrok:
	make ngrok.help

ngrok.run:
	@echo "=====> Running ngrok ..."
	ngrok http ${PROJECT_PORT}
