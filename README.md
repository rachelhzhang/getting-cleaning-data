Please see CodeBook.md for more details

My script in 'run_analysis.R' accomplishes the following with the wearable computing data set:
1. Merge the training and test data sets
2. Extract only measurements that represent mean or standard deviation calculations
3. Name the data columns using the measurement names
4. Add subject data to main data set
5. Replace activity number data to descriptive text for each activity
6. Add activity data to main data set
7. Clean up variable names by removing "-" and "()"
8. Create second, independent tidy data set that shows the average of each measurement for each activity and subject
