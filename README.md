## git-detective

An expect script which iterates through a git repository's history, executes a command provided by the user and checks if the output of the command matches a regex provided by the user.
It starts from the latest commit going backwards and returns the commit hash of the oldest commit where it found a match.


# Dependencies
* expect 
	* expect is an expect script interpreter
	* installing through apt-get should work out of the box
		```bash
		sudo apt-get install expect

# Usage
* create an alias for the script in ~/.bashrc for easier usage (optional)
	```bash
    alias git-detective='expect ~/my/script/dir/git-detective/git-detective.exp'
	```

* go to a git repository
	```bash
	cd ~/my/git/project/dir 
	```

* then run: 
	```bash
	git-detective "ls" "three\.txt"
	```
	- arguments:

		1) the command which the git detective will spawn for each commit 

		2) the regex which the git-detetive will use to check if the output of the command matches

# Example 
I created a directory where the first commit added a file called "one.txt". The second "two.txt" and so on.

```
infa-git-detective "ls" "three\.txt"
spawn git rev-parse --abbrev-ref HEAD
master
EXPECT: starting git-detective
spawn bash /git/detetive/dir/git-detective/sh/gitLogAndInform.sh
EXPECT: git log done
spawn git checkout 9b23357cc24012b1328f68c69ae8546fa27683c6
EXPECT: currently iterating over: 9b23357cc24012b1328f68c69ae8546fa27683c6
EXPECT: hasFoundMatch : false
spawn bash /git/detetive/dir/git-detective/sh/commandWrapper.sh ls
four.txt  one.txt  three.txt  two.txt
spawn git checkout 2e8e70bc3dcd2a207b080bc190cb49ab38e4437f
EXPECT: currently iterating over: 2e8e70bc3dcd2a207b080bc190cb49ab38e4437f
EXPECT: hasFoundMatch : true
spawn bash /git/detetive/dir/git-detective/sh/commandWrapper.sh ls
one.txt  three.txt  two.txt
spawn git checkout f3070d6fa07cbc57b5d2f877af2a6de1d3b95034
EXPECT: currently iterating over: f3070d6fa07cbc57b5d2f877af2a6de1d3b95034
EXPECT: hasFoundMatch : true
spawn bash /git/detetive/dir/git-detective/sh/commandWrapper.sh ls
one.txt  two.txt
EXPECT: It's in 2e8e70bc3dcd2a207b080bc190cb49ab38e4437f
spawn git checkout master
Previous HEAD position was f3070d6 two.txt
Switched to branch 'master'
EXPECT: ending git-detective
```

In the example above we can see the script iterating over commits. It executes ls and checks if the output matches the regex "three\.txt"
Once it finds a match it starts saying "EXPECT: hasFound match : true" however it keeps iterating as we are unsure if this is the oldest commit where we'll get the match.
After it finds a commit with a match and later a commit with no match we know the origin of the match was the previous commit and it stops execution and informs us:
"EXPECT: It's in 2e8e70bc3dcd2a207b080bc190cb49ab38e4437f"

