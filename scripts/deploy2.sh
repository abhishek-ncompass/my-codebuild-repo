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
          VAR1: $VAR3
          VAR2: $VAR5
          VAR3: $VAR6
EOM
