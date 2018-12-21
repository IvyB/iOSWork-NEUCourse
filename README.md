# 实验目的

根据课上所学的知识，编写一个 iOS 应用。

在几天前，一个同学拉着我实现了一个 web 端的 “滴滴打伞” 平台，于是我决定在这门课上，实现一个简单的 "滴滴打伞" iOS 端 APP。



# 运行环境

- macOS 10.13.4

- xcode 9.3.1

- swift 4

- simulator iOS 11.3 


# 原理及实现

## 界面绘制

界面的设计和交互大量使用 storyboard 绘制。

![2018052315270575286697.png](http://td.neu.pw/2018052315270575286697.png)

用 storyboard 实现主要的交互

![20180523152705758442859.png](http://td.neu.pw/20180523152705758442859.png)

由于 storyboard 是一直前进的，查阅资料发现正确的关闭窗口的方式是用代码关闭：

``` swift
@IBAction func closeRegister(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
}
```

如果在 storyboard 上拖拽回上一个界面，会导致重复的叠加视图，几次之后就有可能超内存被杀掉(如下图所示)。

![20180523152705794747562.png](http://td.neu.pw/20180523152705794747562.png)



## 登录注册

### iOS 端

以注册为例
从 storyboard 把组件拖到的 RegisterPageViewController

```swift
    @IBOutlet weak var _emailTP: UITextField!
    @IBOutlet weak var _passwordTP: UITextField!
    @IBOutlet weak var _confirmPasswordTP: UITextField!
    @IBOutlet weak var _phoneTP: UITextField!
    @IBOutlet weak var _sexTP: UISegmentedControl!
```
进行简单的检验
```swift
    @IBAction func registerButtonTapped(_ sender: Any) {
        let username = _emailTP.text
        let password = _passwordTP.text
        let phone = _phoneTP.text
        let sex = _sexTP.titleForSegment(at: _sexTP.selectedSegmentIndex)!

        if((username?.isEmpty)! || (password?.isEmpty)! || (phone?.isEmpty)!) {
            displayAlertMessage(userMessage: "请填写所有信息")
            return
        }
```

发送 post 请求到后端接口

```swift
    func regPost(username:String, password:String, phone:String, sex:String) -> Bool {
        let url = URL(string: "http://127.0.0.1:8001/reg")
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST"
        let paras  = "username="+username+"&password="+password+"&phone="+phone+"&sex"+sex
        request.httpBody = paras.data(using: .utf8)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, respond, error) in
            if let data = data {
                if String(data:data,encoding:.utf8) != nil{
                    success(result)
                }
            }else {
                failure(error!)
            }
        }
        dataTask.resume()
    
        return true
    }
```

调用这个方法，如果返回值为 true，就回到主界面

```swift
if regPost(username: username!, password: password!, phone: phone!, sex: "\(sex)") {
	let myAlert = UIAlertController(title: "提示", message: "注册成功", preferredStyle: UIAlertControllerStyle.alert)
    let okAction = UIAlertAction(title: "成功", style: UIAlertActionStyle.default, handler: {action in self.dismiss(animated: true, completion:nil)})
    myAlert.addAction(okAction)
    self.present(myAlert, animated: true, completion: nil)
}
```

登录的时候，在本地存一个记录，证明当前状态是已登录，不需要每次启动 APP 都输一遍密码

```swift
if (loginPost(username: username!,password: password!)) {
            UserDefaults.standard.set(true, forKey:"isLoggedIn")
            UserDefaults.standard.set(username, forKey:"username")
            UserDefaults.standard.synchronize()
            self.dismiss(animated: true, completion:nil);
        } else {
            displayAlertMessage(userMessage: "登录失败")
        }
```


### 后台程序

后台使用 Python 的 Tornado 架构编写，因为原有的 php 后端接口不好适配。登录成功后下发一个 cookie 值。

``` python
class LoginHandler(tornado.web.RequestHandler):
    def post(self):
        username = self.get_argument("username")
        password = self.get_argument("password")
        sql = 'select username,password from users where username=%s '
        result = db.query(sql, username)
        if result:
            print(result[0]['password'])
            db_pwd = result[0]['password']
            if db_pwd == password:
                self.set_cookie("username", username)  # 设置 cookie
                self.write(username)
            else:                    
                self.write("密码错误")
        else:
            self.write("用户不存在")

class RegHandler(tornado.web.RequestHandler):
    def get(self):
        self.write('post only')

    def post(self):
        username = self.get_argument("username") 
        password = self.get_argument("password")
        phone = self.get_argument("phone") 
        # sex = self.get_argument("sex")
        sex = str(0)
        sql = "insert into users (username,password,telephone,sex) VALUES (%s,%s,%s,%s) "
        db.execute(sql,username,password,phone,sex)
        data = {'status': 0, 'time': int(
            time.time()), 'message': 'successfully'}
        self.write(json.dumps(data))
```



## 附近人界面

附近人是使用 web view 加载一个网页实现的。

Python 后端查数据库得到附近的人，打包成 json 发给前台，渲染成一个 html 文件，swift 将这个网页展示出来。

![20180523152705916452764.png](http://td.neu.pw/20180523152705916452764.png)



viewController 中，先request 请求到这个 html 页面，这里用一个静态页面代替，简单记录实现

```swift
    func show(){
        var url = URL(string: "https://didi.blliblli.cn/neederList.html")
        var request = NSURLRequest(url: url!)
        neederVebView.loadRequest(request as URLRequest)
    }
```

在 viewDidLoad 方法中调用这个方法，使得进入这个页面，自动加载。

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        show()
        // Do any additional setup after loading the view.
    }
```



## 注销

注销的实现，就是把前面登录时，设置的值设为 false

```swift
    @IBAction func buttonLogoutTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
```




# 运行效果

![20180523152705980654218.png](http://td.neu.pw/20180523152705980654218.png)

![image-20180523152030830](/var/folders/cj/5xlctsdn2q9gqj23cj3tqhnr0000gn/T/abnerworks.Typora/image-20180523152030830.png)

接口测试

![image-20180523152306452](/var/folders/cj/5xlctsdn2q9gqj23cj3tqhnr0000gn/T/abnerworks.Typora/image-20180523152306452.png)

# 总结

这次实验学习了xcode 的使用方法，利用 swift 实现了简单的应用设计，体会到了 storyboard 的快速便捷，以及和代码生成布局的优劣。

实验仍有一些不足，比如只是用了简单的 cookie，安全性很差，应该配合 session 或者计算一个校验的 token 与后台进行交互。
