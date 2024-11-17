# Session 3 assignment Task 1:

- Create your github account 
- configure git with your new account 
- create a new repo on your github account 
- clone this repo to your machine 
- create a new branch called feature_a
- make some changes on the branch 
- push the branch to the remote repo
- create a PR to merge your branch to the master branch and add me as a reviewer to approve the changes before merging.

# Ans: 

### Example Commands
```bash
# Configure Git
git config --global user.name "YourGitHubUsername"
git config --global user.email "YourEmail@example.com"

# Clone the repository
git clone https://github.com/k-g-99/project-1.git
cd YourRepo

# Create and switch to a new branch
git checkout -b feature_a

# Make changes, stage, and commit
git add .
git commit -m "Add changes for feature_a"

# Push the branch to the remote repository
git push -u origin feature_a
```