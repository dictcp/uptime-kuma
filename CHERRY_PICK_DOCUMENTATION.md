# Cherry-Pick Setup Documentation

## Overview
This document describes the process of cloning the upstream master branch as a local branch called `local-master` and cherry-picking commits from a local `local-fork` branch to `local-master`.

## What Was Accomplished

### 1. Added Upstream Remote
- Added the upstream repository (louislam/uptime-kuma) as a remote named `upstream`
- Command used: `git remote add upstream https://github.com/louislam/uptime-kuma.git`

### 2. Fetched Upstream Master Branch
- Fetched the latest commits from the upstream master branch
- Command used: `git fetch upstream master --depth=10`
- This brought in the latest commits from the official uptime-kuma repository

### 3. Created local-master Branch
- Created a new local branch named `local-master` tracking `upstream/master`
- Command used: `git branch local-master upstream/master`
- This branch now contains the latest upstream code

### 4. Created local-fork Branch
- Created a `local-fork` branch based on the current working branch
- This branch contains local changes/commits that can be cherry-picked
- Command used: `git branch local-fork copilot/cherry-pick-commit-to-local-master`

### 5. Performed Cherry-Pick
- Checked out the `local-master` branch
- Cherry-picked commit `6728979` (test file addition) from `local-fork` to `local-master`
- Command used: `git cherry-pick 6728979`
- Result: Successfully applied the commit to `local-master`

## Current Branch Structure

```
* local-master (tracking upstream/master)
  - Latest upstream commits
  - Plus cherry-picked commit from local-fork
  
* local-fork
  - Contains local development commits
  - Source for cherry-picking
  
* copilot/cherry-pick-commit-to-local-master
  - Original working branch
```

## Verification

### Branch Status
```bash
$ git branch -vv
copilot/cherry-pick-commit-to-local-master bd493d8 [origin/copilot/cherry-pick-commit-to-local-master] Initial plan
local-fork                                 6728979 Add test file for cherry-pick demonstration
local-master                               1e93cb4 [upstream/master: ahead 1] Add test file for cherry-pick demonstration
```

### Commit History on local-master
```bash
$ git log local-master --oneline -3
1e93cb4 Add test file for cherry-pick demonstration  # Cherry-picked commit
19c2bbd Feature/webhook get method support (#6194)   # Latest upstream
38ec3bc Fix do nothing erroneous api call for Pagerduty (#6231)
```

### Cherry-Picked File
The cherry-picked commit added a test file:
```bash
$ cat test-cherry-pick.txt
# Cherry-pick test file
```

## How to Use

### Manual Cherry-Pick Process
1. Checkout the target branch (local-master):
   ```bash
   git checkout local-master
   ```

2. Identify the commit to cherry-pick from local-fork:
   ```bash
   git log local-fork --oneline
   ```

3. Cherry-pick the desired commit:
   ```bash
   git cherry-pick <commit-hash>
   ```

### Using the Setup Script
Run the provided script to set up the branches automatically:
```bash
./cherry-pick-setup.sh
```

## Notes

- The `local-master` branch is set up to track `upstream/master`, making it easy to keep in sync with upstream changes
- Cherry-picking creates a new commit on the target branch with the same changes but a different commit hash
- If conflicts occur during cherry-pick, resolve them manually, then:
  - `git add <resolved-files>`
  - `git cherry-pick --continue`
- To abort a cherry-pick in progress: `git cherry-pick --abort`

## Success Criteria Met

✅ Clone upstream master branch as local branch `local-master`
✅ Create `local-fork` branch with commits to cherry-pick
✅ Cherry-pick commit from `local-fork` to `local-master`
✅ Verify the cherry-pick was successful
✅ Document the process
