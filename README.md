# cleanarch_dart
### A dart package to generate a cleanarch structury of folders and files
### See also: 
[Typescript Plugin](https://www.npmjs.com/package/cleanarch)

## Installation
```shell
npm i --save-dev cleanarch
```
## Configure
You need creating in a root folder an a cleanarch-cli.config.json, thats a simple json with keys:

- commands: an array of Command object
- schema: an array of Schema object

**Command Object:**
Owns 2 keys: 
    
- command: a command entry point
- comment: Textual Description Of command (optional)
- sufix: A name that correlates the Command with the Schema

**Schema Object**
- sufix: Suffix for generated class. eg: "Usecase"
- extensionSufix: Suffix for extension: eg: ".usecase"
- languageSufix: We currently only supports typescript so: ".ts" 
- defaultImplements: If the class implements an other classes use an array to declare the sufix of them: ["Inteface", "OtherSuffix"]
- defaultDependencies: If the class uses other classes use an array to declare the sufix of them: ["Protocol"]
- useDecorators: If your class use decorators use an array: ["@Service()", "Other()"]
- folder: Generate file into the folder. eg: "./src/core/usecases/"
- abstract: If class is abstract class so true else false;

**Full Simple**
```json
{
    "commands": [
        {
            "command": "st",
            "sufix": "Strategy",
            "comment": "Generate an Interface"
        },
        {
            "command": "uc",
            "sufix": "Usecase",
            "comment": "Generate an Usecase"
        },
        {
            "command": "pc",
            "sufix": "Protocol",
            "comment": "Generate an Protocol"
        },
        {
            "command": "ct",
            "sufix": "Connector",
            "comment": "Generate an Connector"
        }
    ],
    "schema": [
        {
            "sufix": "Strategy",
            "extensionSufix": ".strategy",
            "languageSufix": ".dart",
            "defaultImplementsSuffix": "",
            "defaultDependenciesSuffix": "",
            "useDecorators": [],
            "folder": "./core/strategies/",
            "defaultMethods": [
                "FutureOr<OUTPUT> call({required INPUT input});"
            ],
            "abstract": true
        },
        {
            "sufix": "Usecase",
            "extensionSufix": ".usecase",
            "languageSufix": ".dart",
            "defaultImplementsSuffix": "Strategy",
            "defaultDependenciesSuffix": "Protocol",
            "useDecorators": [],
            "defaultMethods": [],
            "folder": "./core/usecases/",
            "abstract": false
        },
        {
            "sufix": "Protocol",
            "extensionSufix": ".protocol",
            "languageSufix": ".dart",
            "defaultImplementsSuffix": "",
            "defaultMethods": [
                "FutureOr<OUTPUT> call({required INPUT input});"
            ],
            "defaultDependenciesSuffix": "",
            "useDecorators": [],
            "folder": "./core/protocols/",
            "abstract": true
        },
        {
            "sufix": "Connector",
            "extensionSufix": ".connector",
            "languageSufix": ".dart",
            "defaultImplementsSuffix": "Protocol",
            "defaultDependenciesSuffix": "",
            "defaultMethods": [],
            "useDecorators": [
                "import 'dart:async';"
            ],
            "folder": "./adapters/connectors/",
            "abstract": false
        }
    ]
}
```

## Usage
Suppose you have the command: 
```json
{
  "command": "st",
  "suffix": "Strategy",
  "comment": "Generate an Stategy"
}, 
```
and the schema: 
```json
{
  "suffix": "Strategy",
  "extensionSufix": ".strategy",
  "languageSufix": ".dart",
  "defaultImplementsSuffix": "",
  "defaultDependenciesSuffix": "",
  "useDecorators": [],
  "folder": "./core/strategies/",
  "defaultMethods": [
      "FutureOr<OUTPUT> call({required INPUT input});"
  ],
  "abstract": true
},
so to run the command from the command line you must add the following arguments:
> st="ClassName1" 
if u need combine this command with other (eg: to implements a use especify classes)
> st="ClassName" us="Other"
uf u need create a set of Strategies
> st="ClassName1 CLassName2"

## Default Commands:
### all
Generete a full and complete schema
> usage: all=<classes...>
### u
Make the class use a set of classes begining with given classes names
> usage: u=<classes...>
### uo
Make the class use a set of classes with specified names
> usage: uo=<classes...>
### i 
Make the class implements a specific set of classes
> usage: i=<classes...>

#### <classes ...> Means:
A set of Names separed by space, eg:
> "Login Logout Any Other Classes"


## Usage
### Generate a complete Schema :

```shell
cleanarch_dart all="UserLogin UserLogout"
```
**Thats create a bellow structure:**

    src>
        core>
            strategy>
                user-login.strategy.ts
                user-logout.strategy.ts
            usecases>
                user-login.usecase.ts
                user-logout.usecese.ts
            protocols>
                user-login.protocol.ts
                user-logout.protocol.ts
        adapter>
            connectors>
                user-login.protocol.ts
                user-logout.protocol.ts
