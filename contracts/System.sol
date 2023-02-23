pragma solidity >=0.4.22 <0.9.0;

contract System {

    struct Company {
        string name;
        string email;
        string password;
        uint256 certifcate_num;
    }

    struct User {
        string name;
        string email;
        string password;
    }

    struct Product {
        uint id;
        string name;
        string description;
        string companyName;
        
    }

    mapping(address => User) users;
    mapping(address => Company) companies;
    mapping(address => Product) products;


    function register_User(address _useraddress,string memory _name, string memory _email, string memory _password) public {
        users[_useraddress] = User(_name,_email,_password);
    }

    function register_Company(address _compaddress,string memory _name, string memory _email, string memory _password,uint256 _cert_num) public {
        companies[_compaddress] = Company(_name,_email,_password,_cert_num);
    }

    function upload_Product(address _compaddress,uint _id,string memory _name, string memory _description,string memory _companyName) public 
    {
        products[_compaddress] = Product(_id,_name,_description,_companyName);
    }

    function login_user (address user_add , string memory _name , string memory _password) public view returns (bool found)
    {
            User memory user = users[user_add];
            
            // str compare keccak256(bytes(a)) == keccak256(bytes(b));
            if(keccak256(bytes(user.name)) == keccak256(bytes(_name)) && keccak256(bytes(user.password)) == keccak256(bytes(_password)))
                return true;
            else
                return false;
    }

    function login_company (address company_add , string memory _name , string memory _password) public view returns (bool found)
    {
            Company memory company = companies[company_add];
            
            // str compare keccak256(bytes(a)) == keccak256(bytes(b));
            if(keccak256(bytes(company.name)) == keccak256(bytes(_name)) && keccak256(bytes(company.password)) == keccak256(bytes(_password)))
                return true;
            else
                return false;
    }

    
}