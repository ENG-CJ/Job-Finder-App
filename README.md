<video src="./CONTRIBUTION.mp4" width="100%" height="auto" loop autoplay></video>

# INTRODUCTION (JOB FINDER App )
Project-gaan magaciisa waxaa ladhahaa job finder wuxuu noqonayaa meel laga raadin karo shaqooyin-ka banaan
ama shirkadda ay soo post-greeysay, kaliya intaas ayaa loogu tala-galay. project-gaan waxaa ka qeeyb qaadan karo qof walba oo doonaya
inuu aqoontiisa iyo xirfadiisa kor uqaado. waxaana ku dhisi doonaa front-end waxaan adeegsan donna <kbd>Flutter</kbd>
sidoo kale backend waxaan adeegsan donna <kbd>express</kbd> database ahaan waxaan adeegsan doonaa <kbd>Mysql v2</kbd>

# GET STARTED 👋
🔰 step 1 <br>
fork or clone the repo
```
git clone https://github.com/ENG-CJ/Job-Finder-App.git
```
kadib tag folder-ka kadibna waxaa sameeysataa branch local ah
oo ka baxsan **master** branch,

🔰 step 2
```
git branch <branch_name>

```

🔰 step 3 <br>
si aad ugu soo badalato **master** kadibna local branch aad u isticmaashid isticmaal

```
git checkout <branch_name>
```
<hr>
Si aad ula soo dagtid ama ula socotid, update-ka ku dhacayo project-ga waxaa isticmaashaa  <br>

🔰 Step 1
```
git remote add upstream https://github.com/ENG-CJ/Job-Finder-App.git
```

🔰 Step 2<br>
inuu kugu xeray main branch hubi si aad u hubisid isticmaal
```
git remote -v
```
🔰 Step 3<br>
si aad u uhubisid update inuu jiro isticmaal
```diff
+ git fetch upstream master

- git fetch master
- git fetch origin

```
🔰 Step 4<br>
si aad u usoo dagsatid (latest update)
```diff
git fetch upstream master
git merge upstream master

// or one step

+ git pull upstream master


```



# CONFIGURING ALL NECESSARY TOOLS

project-ga marka hore **fork** ku dhaho repository then **clone** dheh oo computer-kaaga ku shubo intaas kadib,
si aad configuring ugu sameeysid server-ka tilmaamahaan raac

## NODE CONFIGURATION
1. folder-ka ay ku qorantahy <kbd>server</kbd> adigoo isticamalayo terminal-ka kadibna qor command-gaan <kbd>cd server</kbd>
2. kadib soo dagso dhamaan tools-ka uu watay server-ka adigoo isticamalayo command-gaan <kbd>npm install</kbd>
3. Kadibna server-ka tijaabi inuu shaqeenayo iyo in kale adigoo isticamalayo command-gaan <kbd> npm start</kbd> intaa kadib
   waxaa tagtaa browser-kaaga kadib raadi url-kaan <kbd>http://localhost:8300/</kbd> kadibna waxaa kuuso bixi message-kaan haddi server-ka uu shaqeenao

```javascript
{ message : "Server is cooking 😋"}

```
## DATABASE CONFIGURATION
**database** qeeybta mysql si aad u configuring ugu sameeysid raact tilmaamahaan
1. folder-ka database waxaa ku qoran <kbd> db data </kbd> file-kaaas qaad
2. kadibna waxaa tagtaa phpmyadmin kadibna waxaa abuurtaa database loo yaqaano <kbd>jobfinderdb</kbd>
3. markii aad abuurtid waxaa tagtaa tab-ka  **import** ay ku qorantahay kadibna soo qaado file-kii database kadibna save dheh <br>

[!NOTE] 🔰
> Hadii aysan wax database ah kurjirin folder-ka  waa abuuri kartaa adigoo raacayo (design-ka database ee kujira isla folder-ka db_data) sido kale database-ka magaiica waa inuu ahaadaa <kbd>jobfinderdb</kbd> intaa kadib datbaase export dheh kadibna soo raaci files-ka aad commit soo dhihi doontid



sidaas waxaa ku sameeysay backend-gii aan u imaano flutter-ka qeeybta front-end, si aad configuring ugu sameeysid raac tilmaamahaan

## FRONTEND (FLUTTER) CONFIGURATION
1. qeeybta flutter waxaa eegtaa file-ka loo yaqaano  pubspec.yml kadibna haddi wax error kugu yimaadan isticmaal command-gaan adigoo
   isticmaalayo terminal-ka <kbd>flutter pub get</kbd>  intaas ayuu kaaga baahanyhy

[!NOTE] 🔰
> fadlan folders-ka sida ay yihiin u isticmaal waxba haka badalin, sidaas ayaan strcuture-ka kasoo dhignay marka sidaas u isticmaal

# NAMING CONVENTIONS AND RULES
haddii aad project-kaan ka shaqeenaysid waxaa shardi ah inaad raaacdo naming conventions
waxyaabaha ladhaho oo ah sida aad magac ugu bixin laheeyd [ variables-ka, functions-ka, classes-ka iyo wixi soo raaca], oo ah xeer kajira programming-ka.

marka si code-kaaga loo fahmo, loona taxliiliyo fadlan raac naming convention rules
haddii aad variable sameenaysid ama function raac naming convention-ka loo yaqaano
<kbd> camalCase <kbd> tusaale waxaan rabaa inaan sameeyo function soo dabacaayo magac

```dart
void getName(String? name){
  print("your name is ${name?? "No name"}!");
}

```
sidaas qof walba wuu fahmi karaa code-kana wuu qurxananayaa lkn haddi sidaan aad isticmaashid kwrn
```dart
void gtname(){
  //🤨🙄🤷‍♂️
}

```
in la fahmo way adkaanaysaa code-kana clean ma noqonaayo, marka code-kaaga si loo aqriyo
loona fahmo, raac <kbd>naming convention rules</kbd>

classes-ka isticmaal : **PascalCase**  <br>
Functions-ka iyo variables-ka isticmaal: **camalCase**<br>
constants-ka isticmaal: **CAPITAL_CASES** -> MY_CONSTANT

# CONTRIBUTION GUIDLINES AND RULES
si aad project-gaan ugu qaadatid xirfadadadan aad tijaabisid fadlan
aqri file-ka contributing gudilines oo ay ku qoranyhy wax yaroo hagis ah<br>
[CONTRIBUTION GUIDLINES](./docs/CONTRIBUTION.md)

# FRAMEWORKS AND TOOLS
Waxaan Isticmaali donna tools-kaan soo socda si aan u dhisno project-gaan

✅ Node/eXpress : For Backend services <br>
✅ Mysql2 : For Database services <br>
✅ Flutter : For FRONTEND services <br>
✅ Provider : For App State management<br>
✅ dioClient Pacakge : For API Linkage Services<br>
✅ Hive Pacakge : For Local DB Services<br>
AND MUCH MORE....

# Folder Structure
```
lib: 
├───consts
├───modals
├───providers
├───services
├───util
│   └───helpers
└───views
    ├───components
    └───pages

```

# ENCOURAGE😊
Project-gaan waa free contribution qof walbana wuu u ufuranyhy, kaliya aqoonteena iyo xirafadeena ayaan kor uqaadanynaa.
sidoo kalane programming-ka waa ku celcelin iyo inaad practical badan sameeyso iyo inaad project badan dhistid si ay wixii kugu cadaadan.

si aad programming-ka wax ugu soo saartid ama aad ku fiicnaatid waa inaad projects badan oo problem xalinaayo aad dhistid, inaad kasoo baxdid confortzone-ka ama waxyaabaha yaryar ee aad ku laa-laabanysid isku day wax weeyn oo adigana aad la yaabtid inaad dhistid. ku dadaal kuna faraxsanoow wax aad qabanysid haddi aadan ku faraxsaneeyn wax aad qabantsid guul inaad gaarto way adkaanaysaa.

# Job Finder Updates ✅
[Click here](./changeLog/versions.md) to download or install the latest version for this application
