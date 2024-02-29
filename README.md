# Network Management and Automation with CI/CD and Jenkins
## jenkins-lab

- This project demonstrates how to manage and automate network configurations using Continuous Integration/Continuous Deployment (CI/CD) practices with Jenkins. It includes a Jenkins setup on Google Cloud Platform (GCP) and a pipeline for automating network changes through Configuration Change Requests (CCRs).

- This Lap is for the perpose of testing Jenkins practice and repository for CAC , CCRs and logs files.
- To access the VM on GCP please use the url below : 
- http://34.16.201.175:8080/

### Building the CI/CD Pipeline
The CI/CD pipeline is defined in a Jenkinsfile which automates the process of applying network changes based on CCRs. It includes stages for initialization, applying configurations, and post-configuration verification.

### Python Scripts for Network Automation
Python scripts are used to parse CCRs and apply changes to network devices using SSH. The start_pipe.py script is the entry point for the CD pipeline.

### Cisco Nexus - Always on Lab
For testing and simulation purposes, the project uses the Cisco Nexus - Always on lab, which provides a sandbox environment for network automation.

### Contributing
Contributions to this project are welcome. Please ensure you follow the best practices for network management and automation.

### Acknowledgments
- Jenkins open source developers team
- Cisco DevNet for the Always on Lab
- All contributors who have provided insights and feedback.


