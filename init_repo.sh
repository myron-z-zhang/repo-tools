#!/bin/sh


pwd=${PWD}
project="project"
organization="yros-one"
repoRoot="RK3399_ANDROID6.0_BOX-SDK_v1.00_20160809"
INIT_REPO_FILE=$1

var=http://www.aaa.com/123.htm
echo ${var#*//}
#if [[ $INIT_REPO_FILE == "" ]; then
#    echo "Please assign initial repo file."
# return 0
#fi

while read line; do
	result=$(echo $line | grep "${project}")
	if [ "$result" != "" ]; then
		echo $line
		#按空格分割分别取第二个path，第三个name
		repoName=$(echo $line | cut -d ' ' -f 2)
		repoPath=$(echo $line | cut -d ' ' -f 3)
		#echo $repoName
		#echo $repoPath
		#取等号右边并去除引号
		repoName=$(echo ${repoName#*=} | sed 's/\"//g')
		androidPath=$(echo ${repoPath#*=} | sed 's/\"//g')
		repoPath=$(echo ${androidPath%/*})
		githubRepoName=$(echo ${repoName} | sed 's/\//-/g')
		#echo "androidPath=" $androidPath
		echo "Current Project Path:" $repoPath
		echo "RK Repo Name:" $repoName
		echo "Github Repo Name:" $githubRepoName
		#curl -u 'litang630:ty717713' https://api.github.com/user/repos -d '{"name":"test"}'		
		
		if [ -d $repoRoot/$androidPath  ]; then
			curl -u 'yydrobot:yU8QTZ2Hmv' https://api.github.com/user/repos -d '{"name":"'$repoName'"}'
			cd $repoRoot/$androidPath
			if [ -d ".git" ]; then
				rm -rf .git
			fi
			git init
			git add .
			git commit -m "initial commit"
                        git remote add origin git@github.com:yydrobot/$githubRepoName.git
			#echo "git remote add origin git@github.com:$organization/$githubRepoName.git"
			git push -u origin master
			cd -
        	else
		    echo "the path "$androidPath" is not exit"
		fi
		echo "------------------"
		continue
	fi
done

