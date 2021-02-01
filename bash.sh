# Set start and end dates
START_DATE="2021-01-31"
END_DATE="2021-12-09"

commit_messages=(
    "Fix typo in the user registration form"
    "Implement caching for API responses"
    "Refactor payment gateway integration logic"
    "Add unit tests for the new user profile feature"
    "Update dependencies to the latest versions"
    "Fix bug with image upload validation"
    "Add dark mode support for the settings page"
    "Optimize performance for loading user dashboard"
    "Cleanup unused styles and components"
    "Update README with setup instructions"
)

git add .
# Loop through each day from START_DATE to END_DATE
while [ "$(date -d "$START_DATE" +%Y-%m-%d)" != "$(date -d "$END_DATE + 1 day" +%Y-%m-%d)" ]; do
    # Check if the day is not Saturday (6) or Sunday (0)
    DAY_OF_WEEK=$(date -d "$START_DATE" +%u) # 1=Monday, ..., 7=Sunday
    if [ "$DAY_OF_WEEK" -lt 8 ]; then
        # Generate a random number of commits for the day (1 to 7 commits)
        NUM_COMMITS=$((RANDOM % 7 + 1))

        for ((i = 1; i <= NUM_COMMITS; i++)); do
            # Generate a random time during the day
            HOUR=$((RANDOM % 24))
            MINUTE=$((RANDOM % 60))
            SECOND=$((RANDOM % 60))

            # Set the commit date and time
            COMMIT_DATE="$START_DATE $HOUR:$MINUTE:$SECOND"
            commit_message=${commit_messages[$RANDOM % ${#commit_messages[@]}]}

            # Create a commit
            export GIT_AUTHOR_DATE="$COMMIT_DATE"
            export GIT_COMMITTER_DATE="$COMMIT_DATE"
            echo "$commit_message" > commit.txt
            git add commit.txt -f
            git commit -m "$commit_message"
        done
    fi

    # Increment the date by 1 day
    START_DATE=$(date -I -d "$START_DATE + 1 day")
done
