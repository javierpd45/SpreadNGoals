import ballerina/io;
import ballerina/regex;

public function main() returns error? 
{
    string|io:Error wheaterData = io:fileReadString("./weather.dat");
    
    string[] splitByLines = regex:split(check wheaterData, "\n");

    int smallestSpreadDay = -1;
    float smallestSpread = -1;
    int i = 0;

    foreach string lines in splitByLines 
    {
        string[] splitBySpace = regex:split(lines, "\\s+");
        if (splitBySpace.length() >= 3 && (i >= 1 && i <= 31)) 
        {
            int day = check int:fromString(splitBySpace[1]);
            string maxTempString = "";
            foreach string item in splitBySpace[2] 
            {
                if (item != "*") 
                {
                    maxTempString = maxTempString + item;                    
                }                
            }
            float maxTemp = check float:fromString(maxTempString);

            string minTempString = "";
            foreach string item in splitBySpace[3] 
            {
                if (item != "*") 
                {
                    minTempString = minTempString + item;                    
                }                
            }
            float minTemp = check float:fromString(minTempString);

            float tempSpread = maxTemp - minTemp;

            if (smallestSpreadDay == -1 || tempSpread < smallestSpread) 
            {
                smallestSpreadDay = day;
                smallestSpread = tempSpread;
            }
        }
        i = i + 1;        
    }

    io:println("The smallest spread day was: ", smallestSpreadDay, "\nWith a spread of: ", smallestSpread);
    return();
}