#!/bin/bash                                                                                                                                                                                                        
SU='"The Crusade of Edda" event starting soon!'                                                                                                                                                                    
BODY=`cat mail1.txt`                                                                                                                                                                                               
SID=1                                                                                                                                                                                                              
NB=${BODY/\"SID\"/$SID}                                                                                                                                                                                            
echo $NB                                                                                                                                                                                                           
/bin/curl -d $NB http://10.148.74.248:7350/v1/igg/mail