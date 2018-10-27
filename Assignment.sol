pragma solidity ^0.4.18;

contract Medical{

    struct Doctor{

        uint doctorId;
        string doctorName;
        string doctorEmail;
        string doctorPhone;
        string doctorAddress;
    }
    
    struct Patient{
        uint patId;
        string patName;
        string patEmail;
        string patPhone;
        string patAddress;
        address[] docterAccess;


    }
  //  address owner;
    
  /*  modifier OnlyOwner(){
        require(owner == msg.sender);
        _;
    }*/

    mapping(address=>Patient) patients;
    mapping(address=>Doctor) doctors;

    address[] public doctorAccts;
    address[] public patientAccts;

    
    event doctorInfo(

        uint doctorId,
        string doctorName,
        string doctorEmail,
        string doctorPhone,
        string doctorAddress
    );

    event patientInfo(

        uint patId,
        string patName,
        string patEmail,
        string patPhone,
        string patAddress
    );

    function setDoctor(address _address,uint _id, string _doctorName , string _doctorEmail , string _doctorPhone , string _doctorAddress)  public{

        var doctor = doctors[_address];
 
        doctor.doctorId = _id;
        doctor.doctorName = _doctorName;
        doctor.doctorEmail = _doctorEmail;
        doctor.doctorPhone = _doctorPhone;
        doctor.doctorAddress = _doctorAddress;
        doctorAccts.push(_address) -1;
        doctorInfo(_id,_doctorName,_doctorEmail,_doctorPhone,_doctorAddress);
    }

    function setPatient(address _address,uint _id, string _patName , string _patEmail , string _patPhone , string _patAddress)  public{

        var patient = patients[_address];
        
        patient.patId = _id;
        patient.patName = _patName;
        patient.patEmail = _patEmail;
        patient.patPhone = _patPhone;
        patient.patAddress = _patAddress;   
        
        patientAccts.push(_address) -1;
        patientInfo(_id,_patName,_patEmail,_patPhone,_patAddress);
    }

    function getDoctors() view public returns(address[]){

        return doctorAccts;
    }


    function getPatients() view public returns(address[]){

        return patientAccts;
    }



    function getDoctor(address _address)  view  public returns (uint,string,string,string,string){
     
        return (doctors[_address].doctorId, doctors[_address].doctorName , doctors[_address].doctorEmail, doctors[_address].doctorPhone , doctors[_address].doctorAddress);
    
    }

    function getPatient(address _address) view  public returns (uint,string,string,string,string){
 
        return (patients[_address].patId, patients[_address].patName, patients[_address].patEmail, patients[_address].patPhone , patients[_address].patAddress);

    }



    function giveAccessToDocter(address _patient,address _doctor)
        {
           var patientData=patients[_patient];
           patientData.docterAccess.push(_doctor)-1;
           
        }
         
    function docAccessAddress(address _patient) view public returns(address[]){
        var pat = patients[_patient];
        return pat.docterAccess; 
    }     
    
    function getPatientData(address _patientToSearch) view public returns (uint,string,string,string,string){
       var patientData=patients[_patientToSearch];
        uint flag=0;
        for (uint i=0;i<patientData.docterAccess.length;i++)
        {
            if(msg.sender==patientData.docterAccess[i])
            {
                flag=1;
                break;
            }
        }
        
        if(flag==1)
        {
          return (patients[_patientToSearch].patId, patients[_patientToSearch].patName, patients[_patientToSearch].patEmail , patients[_patientToSearch].patPhone , patients[_patientToSearch].patAddress);
      
        }

    }


}