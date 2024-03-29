pragma solidity >=0.4.17<0.9.0;

contract Company_Con{
    struct Company {
        string name;
        string email;
        string password;
        uint256 certifcate_num;
    }

    struct Product {
        uint id;
        string name;
        string description;
        string companyName;
    }

    mapping(address => Company) companies;
    mapping(bytes32 => Product) public products;

    function register_Company(address _compaddress,string memory _name, string memory _email, string memory _password,uint256 _cert_num) public {
        companies[_compaddress] = Company(_name,_email,_password,_cert_num);
    }

    function upload_Product(uint _id,string memory _name, string memory _description,string memory _companyName) public 
    {
        Product memory p = Product(_id,_name,_description,_companyName);
        bytes32 p_hashed = keccak256(abi.encode(p.id, p.name, p.description, p.companyName));
        products[p_hashed] = p;
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

    function get_product (bytes32 product_add) external view returns (Product memory Prod){
        return products[product_add];
    }

    function delete_product (bytes32 product_add) public {
        delete products[product_add];
    }
}

contract User_Con {
    struct User {
        string name;
        string email;
        string password;
    }

    Company_Con public _company;
    mapping(address => User) users;

    function register_User(address _useraddress,string memory _name, string memory _email, string memory _password) public {
        users[_useraddress] = User(_name,_email,_password);
    }

    function login_user (address user_add , string memory _name , string memory _password) public view returns (bool found)
    {
            User memory user = users[user_add];
            if(keccak256(bytes(user.name)) == keccak256(bytes(_name)) && keccak256(bytes(user.password)) == keccak256(bytes(_password)))
                return true;
            else
                return false;
    }

    function verify_product (bytes32 product_add) external view returns (bool legit)
    {
        if(_company.get_product(product_add).id == 0){
            return false;
        }
        else{
            return true;
        }
    }
}