// lambda/index.js

export const handler = async (event) => {
    const var1 = process.env.VAR1;
    const var2 = process.env.VAR2;
    const var3 = process.env.VAR3;
  
    console.log(`Environment Variable 1: ${var1}`);
    console.log(`Environment Variable 2: ${var2}`);
    console.log(`Environment Variable 3: ${var3}`);
  
    return {
      statusCode: 200,
      body: JSON.stringify({
        message: 'Lambda function executed successfully!',
        var1,
        var2,
        var3,
      }),
    };
  };
  