### Bellabeat project set up WORKFLOW

📌  Steps in setting up git project on your local machine

![alt tag](https://img.shields.io/badge/git%20-Config%20project-blue)

1. Clone a repo from Github
2. Create a git SSH key and paste it into Github
3. Set up you global and local config file: add username and email for user-

        [user] name = marko markic 
	
	email = marko.markic@bellabeat.com "
	
4. Download in app content framework from submodule in terminal

git submodule update --init --recursive

5. Update Carthage

carthage bootstrap --platform iOS --use-ssh

(Later for faster builds use flag)

carthage bootstrap --platform iOS --use-ssh --cache-builds 😇



📌  Common practice: merge when bigger and longer features all other cases rebase

![alt tag](https://img.shields.io/badge/git%20-Rebase%20project-blue)
### How to Rebase it via Sourcetree?
This was a process of customising Sourcetree so it has more information upon Pushes and changes happening remote/local.

![alt text](https://firebasestorage.googleapis.com/v0/b/bellabeat-e59b7.appspot.com/o/Screen%20Shot%202020-12-09%20at%207.48.16%20PM.png?alt=media&token=2775d14a-c8d5-444a-8235-62d1808fa3c1)

1. Checkout to branch you want to rebase (in this case MASTER)
2. Move to the feature branch you want to take, and go to the LAST commit
3. Right-click and choose REBASE, not Rebase children...
![alt text](https://firebasestorage.googleapis.com/v0/b/bellabeat-e59b7.appspot.com/o/Screen%20Shot%202020-12-10%20at%204.26.00%20PM.png?alt=media&token=e564220e-0741-438a-b531-c3b773fb22db)
4. If there are conflict you will be blocked (if you do not see the Sourcetree messages log, enable them in Preference-Advenced)

5. Solve Conflicts by external tools, editors or Xcode
6. Back in Sourcetree history check commits, and click again on the same feature branch as on the start of rebase
7. Right click there choose again REBASE, will as to Continue Rebase
8. Go to github project and create the Pull request for the rebase
9. Set up members to approve/reject
10. Once one approves you can Force Push in source tree to remote(we want from 4 commits to have only 3)

You will need to enable FORCE PUSH in Preference-Advenced-Allow Force Push

![alt text](https://firebasestorage.googleapis.com/v0/b/bellabeat-e59b7.appspot.com/o/Screen%20Shot%202020-12-11%20at%202.42.21%20PM.png?alt=media&token=ebbfbe77-e391-4578-8c58-4ef515b81849)

Resources:
https://www.coursera.org/lecture/version-control-with-git/sourcetree-rebasing-Miziw

...To be continued
