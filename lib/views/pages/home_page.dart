import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_finder/consts/colors.dart';
import 'package:job_finder/mixins/bottom_navigation_mixin.dart';
import 'package:job_finder/mixins/no_data_found_error.dart';
import 'package:job_finder/util/helpers/text_helper.dart';
import 'package:job_finder/util/icon_image.dart';
import 'package:job_finder/util/icon_text.dart';
import 'package:job_finder/util/text.dart';
import 'package:job_finder/views/components/banner_top.dart';
import 'package:job_finder/views/pages/applied_page.dart';
import 'package:job_finder/views/pages/home_view.dart';

import '../../consts/menus_list.dart';
import '../../mixins/listview_builder_job_card.dart';
import '../../modals/jobs/job_modal.dart';
import '../../util/buton.dart';
import '../../util/categories.dart';
import '../../util/profile.dart';
import '../components/job_card.dart';
import '../components/job_header.dart';

import '../components/login_mode_profile.dart';




  class Home extends StatefulWidget  {
  const  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
  }

  class _HomeState extends State<Home> with BottomNavigationBarMixin {

  final pages=[
  HomePage(),
  AppliedPage(),

  ];
  int currentIndex=0;


  @override
  Widget build(BuildContext context) {
  return Scaffold(
  backgroundColor: Color(0xfff4f4f4),
  appBar: AppBar(
  backgroundColor: colors['white-color'],
  foregroundColor: colors['secondary'],
  centerTitle: true,
  title: CText(
  text: "Job Finder",
  decorations: TextDecorations(
  color: colors['secondary'] as Color,
  weight: FontWeight.bold,
  fontSize: 20),
  ),
  actions: [
  IconButton(onPressed: () {
  showSearch(context: context, delegate: JobSearchDelegate(jobList: HomePage.jobs));
  }, icon: Icon(Icons.search)),
  IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
  ],
  ),
  bottomNavigationBar: curvedNavigationBar(currentIndex,
  onClickIndex: (index){
  if(index>1)
  return;
  setState(() {
  currentIndex=index;
  });
  }

  ),
  drawer: Drawer(
  backgroundColor: Colors.white,
  width: 230,
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  SizedBox(
  width: double.maxFinite,
  height: 280,
  child: DrawerHeader(
  decoration: BoxDecoration(
  color: colors['primary']!.withOpacity(0.8) as Color,
  borderRadius:
  BorderRadius.only(bottomRight: Radius.circular(80))),
  padding: EdgeInsets.all(0),
  margin: EdgeInsets.all(0),
  child: LoginModeProfile(
  ),
  ),
  ),
  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  ListView.builder(
  itemCount: menus.length,
  shrinkWrap: true,
  primary: false,
  itemBuilder: (_,index){
  var menu=menus[index];
  return ListTile(
  onTap: menu['onClick'] != null
  ? ()=> menu['onClick'](context)
      : null,
  iconColor: colors['primary']!.withOpacity(0.7),
  leading: menu['menuIcon'],
  title: CText(text: menu['menuTitle'],
  decorations: TextDecorations(
  fontSize: 18,
  family: "Poppins Medium"
  ),),
  trailing: menu['trailing'],
  );
  })

  ],
  )
  ],
  ),
  ),
  body: pages[currentIndex],
  );
  }
  }





  class JobSearchDelegate extends SearchDelegate with BuildListViewJobCard,NoDataErrorMixin{
  final List<Job> jobList;
  JobSearchDelegate({required this.jobList}):super(
  keyboardType: TextInputType.text
  );


  @override
  String? get searchFieldLabel => "Search Job...";

  @override
  TextStyle? get searchFieldStyle => TextStyle(
  color: colors['secondary'],
  fontFamily: "Poppins Medium",
  fontSize: 18
  );

  @override
  List<Widget>? buildActions(BuildContext context) {

  return[
  IconButton(onPressed: (){
  query='';
  }, icon: FaIcon(FontAwesomeIcons.xmark))
  ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
  return IconButton(onPressed: (){
  close(context, null);
  }, icon: FaIcon(FontAwesomeIcons.angleLeft));
  }

  @override
  Widget buildResults(BuildContext context) {
  return buildJobListView(context, jobList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
  List<Job> matchedResults=[];
  for(var item in jobList) {
  if(item.jobTitle.toLowerCase().contains(query.toLowerCase())) {
  matchedResults.add(item);
  }
  }
  if(matchedResults.isNotEmpty) {
  return buildJobListView(context, matchedResults);
  }

  return noDataError(context,close);
  }



  }







