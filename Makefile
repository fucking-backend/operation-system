workplace = ~/Desktop/fubao-learning/operation-system
commit_reason = "part11"
push:
	cd $(workplace)
	git status
	git add .
	git commit -m $(commit_reason)
	git push origin master
	git status