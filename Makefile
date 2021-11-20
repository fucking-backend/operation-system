workplace = ~/Desktop/fubao-learning/operation-system
commit_reason = "文件系统"
push:
	cd $(workplace)
	git status
	git add .
	git commit -m $(commit_reason)
	git push origin master
	git status