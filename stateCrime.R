library(ggplot2)

# Plot the chart
plotCrime <- function(df, theState,theCrime){
    
    if(theState==""){
        theState <-"Assam"
    }
    if(theCrime==""){
        theCrime="RAPE"
    }
    print(theState)
    # Create a subset frame based on the user choice 
    r <- filter(df,state==theState,crime==theCrime)
    
    r <- r[4:21]
    crm <- t(r)
    year <- as.matrix(c(2001:2018))   
    crm <- cbind(year,crm)
    crimeRate <- as.data.frame(crm) 
    names(crimeRate) <- c("Year","Crimes")
    
    # Draw a plot with regression line of the smoothing
    title <- paste("Incidence of ",tolower(theCrime),"in ",theState)
    g <- ggplot(crimeRate, aes(Year,Crimes))
    g+geom_point() + geom_smooth(method="lm") + ylab(theCrime) +
        ggtitle(title)
    
}

# Plot the choropleth map
plotMap <- function(df,theCrime="RAPE",theYear="X2015"){
    if(theYear==""){
        theYear<-"2001"
    }
    # Create a dataframe based on the crime 
    r <- filter(df,crime==theCrime)
    r <- r[-36,]
    # Set the year for which the crime is required
    year <- paste("X",theYear)
    year <- str_replace_all(year," ","")
    
    # Subset columns with the chosen year
    a <-colnames(r)==year
    
    
    # Make the names in the crimes.csv consistent with the names in IND_adm1.shp
    crimeSet <- select(r,state,crime,which(a))    
    crimeSet$state = as.character(r$state)
    crimeSet[crimeSet$state=="D&N Haveli",]$state = "Dadra and Nagar Haveli"
    crimeSet[crimeSet$state=="Daman & Diu",]$state = "Daman and Diu"
    crimeSet[crimeSet$state=="A&N Islands",]$state = "Andaman and Nicobar"
    crimeSet[crimeSet$state=="Jammu & Kashmir",]$state = "Jammu and Kashmir"
    crimeSet[crimeSet$state=="Delhi UT",]$state = "Delhi"
    crimeSet[crimeSet$state=="Odisha",]$state = "Orissa"
    crimeSet[crimeSet$state=="Uttarakhand",]$state = "Uttaranchal"
    
    # Compute min and max to set the range of shades
    names(crimeSet) <- c("state","crime","yearlyCrimes")
    m= max(crimeSet$yearlyCrimes)
    n = min(crimeSet$yearlyCrimes)
    mid = (m+n)/2
    
    
    b <- head(arrange(crimeSet,desc(yearlyCrimes)),5)
    c <- paste(b$state,"(",b$yearlyCrimes,")")
    stateCrime <- str_replace_all(c," ","")
    
    # Create a data frame to primt the top 5 ofenders
    labels <- data.frame(
        xc = c(90,90,90,90,90), 
        yc = c(7.0,5.6,4.2,2.8,1.4), 
        label = as.vector(stateCrime) 
        
    )
    
    # Plot the choropleth
    title <- paste("Incidence of",tolower(theCrime),"in India in ",theYear)
    ggplot(data = crimeSet)  + 
        geom_map(data = crimeSet, aes(map_id = state, fill = yearlyCrimes), col="brown",  map = ind, ) + 
        expand_limits(x = ind$long, y = ind$lat) +        
        scale_fill_gradient2(low = "pink",                                                                           
                             mid = "red", midpoint = mid, high = "black", limits = c(n, m)) +
        ggtitle(title) +
        geom_text(aes(label="Top offenders",90,8.6))+
        geom_text(data = labels, aes(x = xc, y = yc, label = label))+
        geom_text(aes(label="Data source:https://data.gov.in",90,38,size=0.8)) +
        geom_text(aes(label="J&K borders incorrect",76,35,size=0.8)) +
        geom_text(aes(label="To be fixed.",76,34,size=0.8))
    
    
    
}