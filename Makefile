workplace = ~/Desktop/fubao-learning/operation-system
commit_reason = "初始化&内存管理"
push:
	cd $(workplace)
	git status
	git add .
	git commit -m $(commit_reason)
	git push origin master
	git status