import 'dart:math' as math;
import 'package:flutter/material.dart';

void main()=>runApp(const SkillForge());

const bg=Color(0xFF080B16), card=Color(0xFF12172A), purple=Color(0xFF7C5CFF), cyan=Color(0xFF42D9FF), green=Color(0xFF45E0A8), muted=Color(0xFF9DA6BF);

class SkillForge extends StatelessWidget{
  const SkillForge({super.key});
  Widget build(BuildContext c)=>MaterialApp(debugShowCheckedModeBanner:false,title:'SkillForge',
    theme:ThemeData.dark(useMaterial3:true).copyWith(scaffoldBackgroundColor:bg,colorScheme:ColorScheme.fromSeed(seedColor:purple,brightness:Brightness.dark)),
    home:const Home());
}

class Home extends StatefulWidget{const Home({super.key});State<Home> createState()=>_HomeState();}
class _HomeState extends State<Home>{
  int tab=0; bool teacher=false;
  final titles=['Overview','Assessment','Skill Profile','Practice'];
  Widget page()=>teacher?const Teacher():[const Overview(),const Assessment(),const Skills(),const Practice()][tab];
  Widget build(BuildContext c){final wide=MediaQuery.sizeOf(c).width>850;
    return Scaffold(body:Stack(children:[
      const _Background(),
      Row(children:[if(wide)_Side(tab:tab,onTab:(v)=>setState(()=>tab=v)),
        Expanded(child:Column(children:[
          Container(height:72,padding:const EdgeInsets.symmetric(horizontal:26),
            decoration:BoxDecoration(color:bg.withOpacity(.85),border:Border(bottom:BorderSide(color:Colors.white.withOpacity(.06)))),
            child:Row(children:[if(!wide)const Text('SF',style:TextStyle(color:purple,fontSize:24,fontWeight:FontWeight.w900)),
              const Spacer(),const Icon(Icons.notifications_none,color:muted),const SizedBox(width:18),
              Switch(value:teacher,onChanged:(v)=>setState(()=>teacher=v),activeColor:cyan),
              Text(teacher?'Teacher':'Student',style:const TextStyle(color:muted,fontSize:12)),const SizedBox(width:14),
              const CircleAvatar(backgroundColor:purple,child:Text('H'))])),
          Expanded(child:page())
        ]))]),
      if(!wide)Align(alignment:Alignment.bottomCenter,child:_Bottom(tab:tab,onTab:(v)=>setState(()=>tab=v)))
    ]));
  }
}

class _Background extends StatelessWidget{const _Background();
  Widget build(BuildContext c)=>IgnorePointer(child:CustomPaint(painter:_Glow(),child:const SizedBox.expand()));}
class _Glow extends CustomPainter{
  void paint(Canvas c,Size s){final p=Paint()..maskFilter=const MaskFilter.blur(BlurStyle.normal,100);p.color=purple.withOpacity(.14);c.drawCircle(Offset(s.width*.82,s.height*.18),180,p);p.color=cyan.withOpacity(.07);c.drawCircle(Offset(s.width*.1,s.height*.8),220,p);}
  bool shouldRepaint(covariant CustomPainter o)=>false;
}

class _Side extends StatelessWidget{
 final int tab;final ValueChanged<int> onTab;const _Side({required this.tab,required this.onTab});
 Widget build(BuildContext c)=>Container(width:230,padding:const EdgeInsets.all(18),decoration:BoxDecoration(color:const Color(0xFF0B0F1D),border:Border(right:BorderSide(color:Colors.white10))),
 child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
  const Row(children:[_Logo(),SizedBox(width:10),Text('SkillForge',style:TextStyle(fontSize:21,fontWeight:FontWeight.w800))]),
  const SizedBox(height:32),
  for(int i=0;i<4;i++)_Item(i,tab,onTab),
  const Spacer(),Container(padding:const EdgeInsets.all(14),decoration:BoxDecoration(color:card,borderRadius:BorderRadius.circular(18)),
  child:const Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Icon(Icons.auto_awesome,color:cyan),SizedBox(height:8),Text('Adaptive engine',style:TextStyle(fontWeight:FontWeight.bold)),SizedBox(height:5),Text('Questions change with your mastery.',style:TextStyle(color:muted,fontSize:12))]))
 ]);}
}
class _Logo extends StatelessWidget{const _Logo();Widget build(BuildContext c)=>Container(width:38,height:38,decoration:BoxDecoration(borderRadius:BorderRadius.circular(12),gradient:const LinearGradient(colors:[purple,cyan])),child:const Icon(Icons.code));}
class _Item extends StatelessWidget{
 final int i,tab;final ValueChanged<int> onTab;const _Item(this.i,this.tab,this.onTab);
 Widget build(BuildContext c){final icons=[Icons.grid_view,Icons.code,Icons.auto_graph,Icons.bolt],names=['Overview','Assessment','Skill Profile','Practice'];final a=i==tab;return Padding(padding:const EdgeInsets.only(bottom:7),child:InkWell(onTap:()=>onTab(i),borderRadius:BorderRadius.circular(14),child:AnimatedContainer(duration:const Duration(milliseconds:220),padding:const EdgeInsets.all(13),decoration:BoxDecoration(color:a?purple.withOpacity(.16):Colors.transparent,borderRadius:BorderRadius.circular(14)),child:Row(children:[Icon(icons[i],color:a?Colors.white:muted),const SizedBox(width:12),Text(names[i],style:TextStyle(color:a?Colors.white:muted,fontWeight:a?FontWeight.bold:FontWeight.normal))]))));}
}
class _Bottom extends StatelessWidget{final int tab;final ValueChanged<int> onTab;const _Bottom({required this.tab,required this.onTab});
 Widget build(BuildContext c)=>SafeArea(child:Container(margin:const EdgeInsets.all(14),padding:const EdgeInsets.all(8),decoration:BoxDecoration(color:card,borderRadius:BorderRadius.circular(22)),child:Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[for(int i=0;i<4;i++)InkWell(onTap:()=>onTab(i),child:Icon([Icons.grid_view,Icons.code,Icons.auto_graph,Icons.bolt][i],color:i==tab?cyan:muted))])));}

class _Page extends StatelessWidget{final Widget child;const _Page(this.child);Widget build(BuildContext c)=>SingleChildScrollView(padding:EdgeInsets.fromLTRB(28,26,28,MediaQuery.sizeOf(c).width<850?110:30),child:ConstrainedBox(constraints:const BoxConstraints(maxWidth:1250),child:child));}

class Overview extends StatefulWidget{const Overview({super.key});State<Overview> createState()=>_OverviewState();}
class _OverviewState extends State<Overview> with SingleTickerProviderStateMixin{
 late AnimationController a=AnimationController(vsync:this,duration:const Duration(seconds:8))..repeat();
 void dispose(){a.dispose();super.dispose();}
 Widget build(BuildContext c)=>_Page(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
  Container(width:double.infinity,padding:const EdgeInsets.all(28),decoration:BoxDecoration(borderRadius:BorderRadius.circular(28),gradient:const LinearGradient(colors:[Color(0xFF1B1640),Color(0xFF101D32)]),border:Border.all(color:purple.withOpacity(.3))),
   child:Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    const Text('GOOD MORNING, HARSHINI',style:TextStyle(color:cyan,fontSize:12,fontWeight:FontWeight.w800,letterSpacing:1.4)),
    const SizedBox(height:10),const Text('Ready for your next\ncoding challenge?',style:TextStyle(fontSize:32,fontWeight:FontWeight.w900)),
    const SizedBox(height:12),const Text('The adaptive engine picked a problem targeting Algorithms mastery.',style:TextStyle(color:muted,height:1.4)),
    const SizedBox(height:20),FilledButton.icon(onPressed:(){},icon:const Icon(Icons.play_arrow),label:const Text('Start adaptive test'),style:FilledButton.styleFrom(backgroundColor:purple))
   ])),if(MediaQuery.sizeOf(c).width>650)AnimatedBuilder(animation:a,builder:(_,__)=>SizedBox(width:220,height:190,child:Stack(alignment:Alignment.center,children:[
    Transform.rotate(angle:a.value*math.pi*2,child:Container(width:160,height:160,decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:cyan.withOpacity(.25))))),
    Transform.rotate(angle:-a.value*math.pi*2,child:Container(width:115,height:115,decoration:BoxDecoration(shape:BoxShape.circle,border:Border.all(color:purple.withOpacity(.5))))),
    Container(width:75,height:75,decoration:const BoxDecoration(shape:BoxShape.circle,gradient:LinearGradient(colors:[purple,cyan])),child:const Icon(Icons.code,size:34))
   ])))])
  ),
  const SizedBox(height:25),const Text('Your progress',style:TextStyle(fontSize:22,fontWeight:FontWeight.w800)),const SizedBox(height:14),
  const Wrap(spacing:14,runSpacing:14,children:[_Metric('Overall mastery','78%','+6.4%',green),_Metric('Problems solved','142','+18 this week',cyan),_Metric('Average speed','2m 18s','14s faster',purple),_Metric('Streak','12 days','Personal best',Colors.orange)]),
  const SizedBox(height:28),const Text('Topic mastery',style:TextStyle(fontSize:20,fontWeight:FontWeight.w800)),const SizedBox(height:14),
  const _Mastery('Arrays & Strings',.91,'Advanced'),const _Mastery('Data Structures',.76,'Intermediate'),const _Mastery('Algorithms',.68,'Intermediate'),const _Mastery('SQL & Databases',.54,'Developing')
 ]));
}}
class _Metric extends StatelessWidget{final String a,b,d;final Color color;const _Metric(this.a,this.b,this.d,this.color);Widget build(BuildContext c)=>Container(width:245,padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:card,borderRadius:BorderRadius.circular(20),boxShadow:[BoxShadow(color:Colors.black26,blurRadius:20)]),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(a,style:const TextStyle(color:muted,fontSize:12)),const SizedBox(height:16),Text(b,style:const TextStyle(fontSize:28,fontWeight:FontWeight.w900)),const SizedBox(height:5),Text(d,style:TextStyle(color:color,fontSize:11,fontWeight:FontWeight.bold))]));}
class _Mastery extends StatelessWidget{final String title,level;final double value;const _Mastery(this.title,this.value,this.level);Widget build(BuildContext c)=>Container(margin:const EdgeInsets.only(bottom:10),padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:card,borderRadius:BorderRadius.circular(16)),child:Row(children:[Expanded(child:Text(title,style:const TextStyle(fontWeight:FontWeight.bold))),SizedBox(width:220,child:LinearProgressIndicator(value:value,minHeight:7,backgroundColor:Colors.white10,color:value>.8?green:cyan)),const SizedBox(width:14),Text((value*100).round().toString()+'%',style:const TextStyle(fontWeight:FontWeight.bold)),const SizedBox(width:18),SizedBox(width:100,child:Text(level,style:const TextStyle(color:muted,fontSize:12)))]));}

class Assessment extends StatelessWidget{const Assessment({super.key});Widget build(BuildContext c)=>_Page(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Adaptive assessment',style:TextStyle(fontSize:30,fontWeight:FontWeight.w900)),const SizedBox(height:8),const Text('Questions adapt to mastery, recent results and solving time.',style:TextStyle(color:muted)),const SizedBox(height:24),const _Q('01','Algorithms','Find the longest subarray with a target sum','Intermediate','08:00'),const _Q('02','Data Structures','Design an efficient LRU cache','Intermediate','10:00')]));}
class _Q extends StatelessWidget{final String n,t,title,d,time;const _Q(this.n,this.t,this.title,this.d,this.time);Widget build(BuildContext c)=>Container(margin:const EdgeInsets.only(bottom:14),padding:const EdgeInsets.all(22),decoration:BoxDecoration(color:card,borderRadius:BorderRadius.circular(22)),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Row(children:[Text(n,style:const TextStyle(color:purple,fontSize:22,fontWeight:FontWeight.w900)),const SizedBox(width:12),Text(t,style:const TextStyle(color:cyan,fontWeight:FontWeight.bold)),const Spacer(),Text('Expected $time',style:const TextStyle(color:muted,fontSize:12))]),const SizedBox(height:16),Text(title,style:const TextStyle(fontSize:20,fontWeight:FontWeight.w800)),const SizedBox(height:12),Text(d,style:const TextStyle(color:Colors.orange)),const SizedBox(height:16),Align(alignment:Alignment.centerRight,child:OutlinedButton.icon(onPressed:(){},icon:const Icon(Icons.arrow_forward),label:const Text('Start problem')))]));}

class Skills extends StatelessWidget{const Skills({super.key});Widget build(BuildContext c)=>_Page(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Skill profile',style:TextStyle(fontSize:30,fontWeight:FontWeight.w900)),const SizedBox(height:8),const Text('Strengths, weak topics and learning gaps.',style:TextStyle(color:muted)),const SizedBox(height:25),const Wrap(spacing:16,runSpacing:16,children:[_Skill('Arrays','91%','Strong',green),_Skill('Strings','86%','Strong',green),_Skill('Algorithms','68%','Growing',cyan),_Skill('SQL','54%','Focus',Colors.orange),_Skill('Graphs','42%','Focus',Colors.pink),_Skill('Dynamic Programming','38%','Focus',Colors.pink)])]));}
class _Skill extends StatelessWidget{final String a,b,d;final Color color;const _Skill(this.a,this.b,this.d,this.color);Widget build(BuildContext c)=>Container(width:220,padding:const EdgeInsets.all(20),decoration:BoxDecoration(color:card,borderRadius:BorderRadius.circular(20),border:Border.all(color:color.withOpacity(.2))),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(a,style:const TextStyle(color:muted)),const SizedBox(height:12),Text(b,style:const TextStyle(fontSize:31,fontWeight:FontWeight.w900)),const SizedBox(height:6),Text(d,style:TextStyle(color:color,fontWeight:FontWeight.bold,fontSize:12))]));}

class Practice extends StatelessWidget{const Practice({super.key});Widget build(BuildContext c)=>_Page(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Recommended practice',style:TextStyle(fontSize:30,fontWeight:FontWeight.w900)),const SizedBox(height:8),const Text('Targeted practice from recent attempts and learning gaps.',style:TextStyle(color:muted)),const SizedBox(height:25),const _P('Graphs: BFS fundamentals','12 min • 3 problems','High impact',purple),const _P('SQL: JOIN patterns','15 min • 4 problems','Recommended',cyan),const _P('Dynamic programming basics','20 min • 5 problems','Build foundation',green)]));}
class _P extends StatelessWidget{final String a,b,d;final Color color;const _P(this.a,this.b,this.d,this.color);Widget build(BuildContext c)=>Container(margin:const EdgeInsets.only(bottom:13),padding:const EdgeInsets.all(19),decoration:BoxDecoration(color:card,borderRadius:BorderRadius.circular(19)),child:Row(children:[Icon(Icons.auto_awesome,color:color),const SizedBox(width:15),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(a,style:const TextStyle(fontWeight:FontWeight.bold)),const SizedBox(height:5),Text(b,style:const TextStyle(color:muted,fontSize:12))])),Text(d,style:TextStyle(color:color,fontWeight:FontWeight.bold,fontSize:11))]));}

class Teacher extends StatelessWidget{const Teacher({super.key});Widget build(BuildContext c)=>_Page(Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text('Teacher command center',style:TextStyle(fontSize:30,fontWeight:FontWeight.w900)),const SizedBox(height:8),const Text('Class progress, individual reports and flagged activity.',style:TextStyle(color:muted)),const SizedBox(height:25),const Wrap(spacing:14,runSpacing:14,children:[_Metric('Students','128','+8 this month',cyan),_Metric('Average mastery','72%','+4.8%',green),_Metric('Assessments','346','This month',purple),_Metric('Flagged','7','Needs review',Colors.orange)]),const SizedBox(height:28),const _Mastery('Algorithms',.74,'Class average'),const _Mastery('Data Structures',.81,'Class average'),const _Mastery('SQL',.59,'Class average')]));}
