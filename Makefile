#
# Simple Makefile for conviently testing, building and deploying experiment.
#
PROJECT = eprints-vagrant

status:
	git status

save:
	if [ "$(msg)" != "" ]; then git commit -am "$(msg)"; else git commit -am "Quick Save"; fi
	git push origin $(BRANCH)

