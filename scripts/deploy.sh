# Echo the CodeBuild version and resolved version (for debugging)
# echo "CodeBuild Source Version: $CODEBUILD_SOURCE_VERSION"
# echo "CodeBuild Resolved Source Version: $CODEBUILD_RESOLVED_SOURCE_VERSION"

# Create CloudFormation template.yaml with environment variables
cat > template.yaml <<EOM
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31
Resources:
  abhishekLambdaCodebuild:
    Type: AWS::Serverless::Function
    Properties:
      CodeUri: lambda/
      FunctionName: abhishek-codebuild-$VAR1
      Handler: index.handler
      Runtime: nodejs16.x
      Environment:
        Variables:
          VAR1: $VAR1
          VAR2: $VAR2
          VAR4: $VAR4
          VAR4: $VAR4
EOM

# # Deploy using AWS CloudFormation
# echo "Deploying CloudFormation stack..."
# aws cloudformation deploy \
#   --template-file template.yaml \
#   --stack-name abhishek-codebuild-${VAR1} \
#   --capabilities CAPABILITY_IAM

# # Optional: Check the stack status
# aws cloudformation describe-stacks --stack-name abhishek-codebuild-${VAR1}
