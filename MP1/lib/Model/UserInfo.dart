// ignore: file_names
import 'UserProjectInfo.dart';

class UserInfo {
   String name;
   String position;
   String company;
   String phone;
   String email;
   String address1;
   String address2;

  // each entry is a record with named fields that describe a degree
   List<Map<String, dynamic>> education;

  // each entry is an instance of `ProjectInfo` that contains project details
   List<ProjectInfo> projects;

  UserInfo({
  required this.name, required this.position,
  required this.company, required this.phone, 
  required this.email, required this.address1,
  required this.address2,required this.education,
  required this.projects
  });
  static List< UserInfo > user = [];

   static void setUserInfo(){
    user.add(
      UserInfo(
      name: 'John Doe',
      position: 'Software Engineer',
      company: 'ACME Enterprises',
      phone: '(312) 555-1212',
      email: 'john.doe@acme.com',
      address1: '10 W 31st St.',
      address2: 'Chicago, IL 60616',
      education: [
        {'year': '2019-2021', 'name': 'University of South Florida     ', 'gpa': '3.8'},
        {'year': '2021-2023', 'name': 'Illinois Institute of Technology', 'gpa': '3.9'},
        ],
      projects: [
        ProjectInfo(
          projectName: 'Project X',
          projectDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
        ),
        ProjectInfo(
          projectName: 'Project Y',
          projectDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
        ),
         ProjectInfo(
          projectName: 'Project X',
          projectDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
        ),
         ProjectInfo(
          projectName: 'Project X',
          projectDescription: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
        ),
    ],
  ),
);
}

   static List<UserInfo> getUserInfo(){
    setUserInfo();
    return user;
  }
}