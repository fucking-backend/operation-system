workplace = ~/Desktop/fubao-learning/operation-system
commit_reason = "设备IO"
push:
	cd $(workplace)
	git status
	git add .
	git commit -m $(commit_reason)
	git push origin master
	git status