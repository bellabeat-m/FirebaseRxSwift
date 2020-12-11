### Bellabeat project set up WORKFLOW

📌  Steps in setting up git project on your local machine
![alt tag](https://img.shields.io/badge/git%205-Rebase%20project-blue)

1. Clone a repo from Github
2. Create a git SSH key and paste it into Github
3. Set up you global and local config file: add username and email for user-
" [user]
	name = marko markic
	email = marko.markic@bellabeat.com "
4. Download in app content framework from submodule in terminal
git submodule update --recursive
5. Update Carthage
carthage bootstrap --platform iOS --use-ssh
(Ili za sve targets)
carthage bootstrap --platform iOS --use-ssh --cache-builds



📌  Common prectice: merge when bigger and longer features all other cases rebase
### How to do it via Sourcetree?
This was a long process of customising Sourcetree so it has more information upon Pushes and changes happening remote/local.


Resources:
https://www.coursera.org/lecture/version-control-with-git/sourcetree-rebasing-Miziw

