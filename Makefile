workplace = ~/Desktop/fubao-learning/operation-system
commit_reason = "next 内存管理"
push:
	cd $(workplace)
	git status
	git add .
	git commit -m $(commit_reason)
	git status