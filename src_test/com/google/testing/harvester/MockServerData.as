package com.google.testing.harvester {
	import flash.utils.Dictionary;
	
	public class MockServerData extends Dictionary {
		
		public var projectChangListMap : Dictionary = new Dictionary();
		public var projects : Array = [];
		
		private var project1:Project = createProject("Dev1,Dev2,Dev3", "Project1", "http://localhost");
		private var project2:Project = createProject("Dev2,Dev3", "Project2", "http://localhost2");
		
		public function MockServerData() {
			projects.push(project1);
			projects.push(project2);
			projectChangListMap[project1.name] = changeList1;
			projectChangListMap[project2.name] = changeList2;
		}
		
		public static var instance:MockServerData = new MockServerData();
		
		public function changelists(name:String):String {
			var changeLists:String = projectChangListMap[name];
			if (changeLists == null) changeLists = "";
			return changeLists;
		}
		
		public function createProject(developers:String, proName:String, path:String):Project {
			var project:Project = new Project();
			project.developers = developers;
			project.name = proName;
			project.path = path;
			
			return project;
		}
		
		public function addProjectAndChangeList(proName:String, changeLists:String):void {
			projectChangListMap[proName] = changeLists;
		}
		
		public function getProjectsInfo():String {
			var allProjects:String = "";
			for each(var project:Project in projects) {
				allProjects += project.toRawString();
			}
			return allProjects;
		}			
				
		public var changeList1:String = 
				"7714519,aswami,Java,2008-07-15 13:54:13,pepstein,2,0,1,0,0,0\n" + 
				"7736401,bridgwater,Java,2008-07-17 10:24:41,samnewman;pepstein;ocarlsen,80,17,37,0,0,0\n" + 
				"8169768,dtm,Java,2008-09-03 13:55:47,pepstein;samnewman,17,0,0,0,0,0\n" + 
				"8132376,dtm,Java,2008-08-28 17:59:31,pepstein;samnewman;rongou,0,4,1,0,0,0\n" + 
				"8015716,dtm,Java,2008-08-18 07:09:27,pepstein;samnewman;rongou,4,4,2,0,0,0\n" + 
				"8161863,hhchan,Java,2008-09-02 18:45:28,pepstein;samnewman,10,1,3,36,0,6";
				
		public var changeList2:String = 
				"1,(no author),,2008-03-01 13:42:51,,0,0,0,0,0,0                                                                                                         \n" +
				"2,misko.hevery,Other;Java,2008-03-01 14:25:28,,7596,0,0,3715,0,0                                                                                        \n" +
				"3,misko.hevery,,2008-03-01 14:27:44,,0,0,0,0,0,0                                                                                                        \n" +
				"4,Misko.Hevery,,2008-03-01 14:50:07,,0,0,0,0,0,0                                                                                                        \n" +
				"5,ralph.jocham,Java,2008-03-01 16:43:42,,385,0,0,224,0,0                                                                                                \n" +
				"6,ralph.jocham,,2008-03-01 16:46:09,,0,0,0,0,0,0                                                                                                        \n" +
				"7,ralph.jocham,Java,2008-03-02 09:33:09,,109,8,11,0,0,0                                                                                                 \n" +
				"8,ralph.jocham,,2008-03-02 09:46:16,,0,0,0,0,0,0                                                                                                        \n" +
				"9,ralph.jocham,Java,2008-03-03 09:55:14,,137,14,14,83,5,3                                                                                               \n" +
				"10,ralph.jocham,Java,2008-03-03 10:49:44,,29,21,4,0,0,0                                                                                                 \n" +
				"11,ralph.jocham,Java,2008-03-03 13:11:46,,27,15,8,0,0,0                                                                                                 \n" +
				"12,ralph.jocham,,2008-03-03 16:03:36,,0,0,0,0,0,0                                                                                                       \n" +
				"13,ralph.jocham,,2008-04-04 16:26:27,,0,0,0,0,0,0                                                                                                       \n" +
				"14,ralph.jocham,,2008-04-04 17:02:15,,0,0,0,0,0,0                                                                                                       \n" +
				"15,misko.hevery,Java,2008-04-04 21:00:16,,0,0,0,8,4,1                                                                                                   \n" +
				"16,misko.hevery,Java,2008-04-00 11:43:50,,9,6,17,0,0,2                                                                                                  \n" +
				"17,misko.hevery,Java,2008-04-00 11:45:50,,0,0,1,0,0,0                                                                                                   \n" +
				"18,misko.hevery,Java,2008-04-04 21:29:35,,36,0,14,0,0,0                                                                                                 \n" +
				"19,ralph.jocham,,2008-04-01 13:47:23,,0,0,0,0,0,0                                                                                                       \n" +
				"20,ralph.jocham,,2008-04-01 14:02:15,,0,0,0,0,0,0                                                                                                       \n" +
				"21,ralph.jocham,,2008-04-01 14:09:15,,0,0,0,0,0,0                                                                                                       \n" +
				"22,ralph.jocham,,2008-04-01 14:20:32,,0,0,0,0,0,0                                                                                                       \n" +
				"23,misko.hevery,Java,2008-04-05 13:42:03,,264,71,24,49,1,2                                                                                              \n" +
				"24,misko.hevery,Java,2008-04-05 15:54:51,,30,1,5,31,25,0                                                                                                \n" +
				"25,misko.hevery,Java,2008-04-00 16:50:52,,397,17,138,237,10,78                                                                                          \n" +
				"26,misko.hevery,Java,2008-04-00 17:47:35,,2,2,1,34,15,15                                                                                                \n" +
				"27,misko.hevery,Java,2008-04-00 21:25:57,,93,76,170,0,0,0                                                                                               \n" +
				"28,misko.hevery,Java,2008-04-01 10:55:19,,15,4,4,13,4,0                                                                                                 \n" +
				"29,misko.hevery,Java,2008-04-01 11:24:16,,1,1,3,0,0,0                                                                                                   \n" +
				"30,misko.hevery,Java,2008-04-01 13:09:03,,44,10,22,13,0,4                                                                                               \n" +
				"31,misko.hevery,Java,2008-04-04 13:36:38,,11,27,18,0,0,0                                                                                                \n" +
				"32,kunalt,Java,2008-04-02 14:48:06,,7,2,2,2,2,1                                                                                                         \n" +
				"33,kunalt,Java,2008-04-05 10:45:44,,57,43,39,98,22,31                                                                                                   \n" +
				"34,kunalt,,2008-05-02 10:42:25,,0,0,0,0,0,0                                                                                                             \n" +
				"35,misko.hevery,,2008-05-02 11:36:49,,0,0,0,0,0,0                                                                                                       \n" +
				"36,misko.hevery,Java,2008-05-05 16:45:11,,0,3,0,0,0,0                                                                                                   \n" +
				"37,kunalt,Javascript;Java,2008-05-01 15:32:41,,123,2,6,135,4,6                                                                                          \n" +
				"38,kunalt,Javascript;Other;Java,2008-05-03 14:19:33,,13887,12,37,303,6,18                                                                               \n" +
				"39,kunalt,Java,2008-05-03 14:32:46,,0,0,0,4,0,3                                                                                                         \n" +
				"40,kunalt,Java,2008-05-03 14:40:11,,0,2,2,28,8,8                                                                                                        \n" +
				"41,kunalt,Java,2008-05-05 15:39:53,,533,105,58,370,65,43                                                                                                \n" +
				"42,kunalt,Java,2008-05-05 15:44:32,,0,0,2,0,0,0                                                                                                         \n" +
				"43,misko.hevery,Java,2008-05-03 11:22:28,,119,80,27,59,32,17                                                                                            \n" +
				"44,misko.hevery,Java,2008-05-06 02:02:49,,5,4,4,7,4,25                                                                                                  \n" +
				"45,misko.hevery,Java,2008-05-06 02:09:36,,0,0,1,0,0,0                                                                                                   \n" +
				"46,misko.hevery,Java,2008-05-06 02:13:00,,0,0,0,2,0,4                                                                                                   \n" +
				"47,Misko.Hevery,Java,2008-05-06 02:47:27,,10,0,1,10,0,3                                                                                                 \n" +
				"48,kunalt,Java,2008-06-03 12:17:01,,9,0,2,12,7,3                                                                                                        \n" +
				"49,kunalt,Java,2008-06-01 19:17:16,,278,50,200,277,63,214                                                                                               \n" +
				"50,kunalt,Java,2008-06-01 19:19:50,,0,2,1,0,0,0                                                                                                         \n" +
				"51,kunalt,Java,2008-06-02 15:12:44,,31,0,6,31,0,5                                                                                                       \n" +
				"52,dstalnov,,2008-06-01 02:38:23,,0,0,0,0,0,0                                                                                                           \n" +
				"53,ralph.jocham@gmail.com,Java,2008-06-01 09:33:23,,1220,433,1556,169,31,133                                                                            \n" +
				"54,ralph.jocham@gmail.com,Java,2008-06-01 10:07:15,,1,0,0,0,0,0                                                                                         \n" +
				"55,dstalnov,,2008-07-04 04:30:38,,0,0,0,0,0,0                                                                                                           \n" +
				"56,havardrb,Java,2008-07-04 07:05:33,,733,2,30,113,0,0                                                                                                  \n" +
				"57,havardrb,Java,2008-07-04 08:58:05,,359,51,231,146,35,144                                                                                             \n" +
				"58,markusclermont,Java,2008-07-05 01:28:10,,3,5,0,0,0,0                                                                                                 \n" +
				"59,markusclermont,Java,2008-07-05 01:28:30,,30,0,1,0,0,0                                                                                                \n" +
				"60,markusclermont,Java,2008-07-05 01:28:45,,29,1,7,0,0,0                                                                                                \n" +
				"61,markusclermont,Java,2008-07-05 01:29:04,,0,21,0,0,0,0                                                                                                \n" +
				"62,markusclermont,Java,2008-07-05 01:42:47,,21,0,0,0,0,0                                                                                                \n" +
				"63,havardrb,Java,2008-07-05 01:46:17,,0,0,0,41,36,1                                                                                                     \n" +
				"64,havardrb,Java,2008-07-05 02:03:58,,99,17,111,22,3,18                                                                                                 \n" +
				"65,havardrb,Java,2008-07-05 02:24:41,,44,30,61,0,0,0                                                                                                    \n" +
				"66,havardrb,Java,2008-07-05 02:29:24,,6,10,6,0,0,0                                                                                                      \n" +
				"67,markusclermont,Java,2008-07-05 02:39:59,,16,0,4,0,0,0                                                                                                \n" +
				"68,markusclermont,Java,2008-07-05 03:09:52,,78,6,19,0,0,0                                                                                               \n" +
				"69,markusclermont,Java,2008-07-05 03:11:20,,0,0,4,0,0,0                                                                                                 \n" +
				"70,markusclermont,Java,2008-07-05 03:22:31,,15,4,23,10,2,10                                                                                             \n" +
				"71,havardrb,Java,2008-07-05 03:29:12,,14,16,34,0,0,0                                                                                                    \n" +
				"72,havardrb,Java,2008-07-05 03:30:26,,0,0,2,0,0,0                                                                                                       \n" +
				"73,markusclermont,Java,2008-07-05 03:49:13,,0,0,0,19,0,15                                                                                               \n" +
				"74,markusclermont,Java,2008-07-05 04:51:41,,46,12,2,0,0,0                                                                                               \n" +
				"75,havardrb,Java,2008-07-05 05:06:53,,171,118,104,4,4,4                                                                                                 \n" +
				"76,havardrb,Java,2008-07-05 05:30:33,,0,0,0,7,26,17                                                                                                     \n" +
				"77,havardrb,Java,2008-07-05 06:16:25,,0,0,1,0,0,0                                                                                                       \n" +
				"78,markusclermont,Java,2008-07-05 07:24:59,,733,22,52,2,1,1                                                                                             \n" +
				"79,markusclermont,Java,2008-07-05 07:25:52,,1,0,2,0,0,0                                                                                                 \n" +
				"80,markusclermont,Java,2008-07-05 08:02:04,,18,14,8,0,0,0                                                                                               \n" +
				"81,markusclermont,Java,2008-07-05 08:15:06,,7,0,4,0,0,0                                                                                                 \n" +
				"82,havardrb,Java,2008-07-05 08:18:52,,1,1,4,1,0,2                                                                                                       \n" +
				"83,markusclermont,Java,2008-07-05 08:46:20,,138,67,42,0,0,0                                                                                             \n" +
				"84,misko.hevery,Java,2008-07-05 15:59:04,,0,0,0,11,12,27                                                                                                \n" +
				"85,misko.hevery,Java,2008-07-05 16:03:39,,24,15,50,0,0,0                                                                                                \n" +
				"86,dstalnov,Other;Java,2008-07-01 06:28:49,,12556,0,0,0,0,0                                                                                             \n" +
				"87,havardrb,Java,2008-07-03 02:41:49,,197,389,301,88,87,95                                                                                              \n" +
				"88,markusclermont,Java,2008-07-03 02:41:52,,28,0,8,0,0,0                                                                                                \n" +
				"89,havardrb,Java,2008-07-03 03:19:19,,41,55,100,40,41,66                                                                                                \n" +
				"90,markusclermont,Java,2008-07-03 04:14:15,,56,9,16,13,0,2                                                                                              \n" +
				"91,havardrb,Java,2008-07-03 04:17:33,,14,0,0,15,3,10                                                                                                    \n" +
				"92,dstalnov,Java,2008-07-03 04:19:27,,483,34,312,76,0,0                                                                                                 \n" +
				"93,havardrb,Java,2008-07-03 05:35:09,,198,115,110,97,78,113                                                                                             \n" +
				"94,dstalnov,Java,2008-07-03 05:47:26,,300,16,24,53,0,0                                                                                                  \n" +
				"95,havardrb,Java,2008-07-03 08:09:50,,1,0,0,0,0,0                                                                                                       \n" +
				"96,havardrb,Java,2008-07-03 08:17:08,,0,0,0,15,0,6                                                                                                      \n" +
				"97,havardrb,Java,2008-07-03 08:54:27,,977,1153,256,72,163,38                                                                                            \n" +
				"98,markusclermont,Java,2008-07-03 09:45:39,,227,279,10,0,0,0                                                                                            \n" +
				"99,markusclermont,Java,2008-07-03 10:25:31,,118,110,20,0,0,0                                                                                            \n" +
				"100,Misko.Hevery,,2008-07-05 10:43:24,,0,0,0,0,0,0                                                                                                      \n" +
				"101,Misko.Hevery,,2008-07-05 10:47:41,,0,0,0,0,0,0                                                                                                      \n" +
				"102,Misko.Hevery,,2008-07-05 10:48:41,,0,0,0,0,0,0                                                                                                      \n" +
				"103,Misko.Hevery,,2008-07-05 11:17:12,,0,0,0,0,0,0                                                                                                      \n" +
				"104,Misko.Hevery,,2008-07-05 11:17:21,,0,0,0,0,0,0                                                                                                      \n" +
				"105,Misko.Hevery,,2008-07-05 11:17:40,,0,0,0,0,0,0                                                                                                      \n" +
				"106,Misko.Hevery,,2008-07-05 11:17:58,,0,0,0,0,0,0                                                                                                      \n" +
				"107,Misko.Hevery,,2008-07-05 11:18:18,,0,0,0,0,0,0                                                                                                      \n" +
				"108,Misko.Hevery,,2008-07-05 11:18:48,,0,0,0,0,0,0                                                                                                      \n" +
				"109,dstalnov,Java,2008-08-01 02:38:43,,764,254,0,43,11,59                                                                                               \n" +
				"110,bwsanders,,2008-08-01 03:57:52,,0,0,0,0,0,0                                                                                                         \n" +
				"111,Dr.Robert.Nilsson,Java,2008-08-01 06:04:09,,38,21,447,16,0,0                                                                                        \n" +
				"112,Misko.Hevery,Java,2008-08-02 14:13:04,,101,76,136,76,262,570                                                                                        \n" +
				"113,Misko.Hevery,Java,2008-08-02 14:46:41,,26,12,36,16,6,18                                                                                             \n" +
				"114,Misko.Hevery,Java,2008-08-03 16:21:36,,58,72,0,26,23,0                                                                                              \n" +
				"115,dstalnov,Java,2008-08-04 01:20:18,,381,0,0,0,0,0                                                                                                    \n" +
				"116,Misko.Hevery,Java,2008-08-05 16:59:13,,332,0,0,44,0,1                                                                                               \n" +
				"117,Misko.Hevery,,2008-08-05 20:29:58,,0,0,0,0,0,0                                                                                                      \n" +
				"118,Misko.Hevery,,2008-08-05 20:37:51,,0,0,0,0,0,0                                                                                                      \n" +
				"119,Misko.Hevery,Java,2008-08-06 08:48:45,,6,141,2,126,2,0                                                                                              \n" +
				"120,Misko.Hevery,Java,2008-08-06 08:54:35,,0,0,0,4,0,0                                                                                                  \n" +
				"121,dstalnov,Java,2008-08-06 10:17:11,,209,10,26,28,1,7                                                                                                 \n" +
				"122,dstalnov,Java,2008-08-00 02:01:20,,85,0,0,45,0,0                                                                                                    \n" +
				"123,dstalnov,Java,2008-08-00 13:56:04,,645,60,20,96,12,4                                                                                                \n" +
				"124,dstalnov,Java,2008-08-01 14:47:26,,579,6,6,159,0,1                                                                                                  \n" +
				"125,dstalnov,Java,2008-08-02 10:47:50,,864,21,0,205,0,0                                                                                                 \n" +
				"126,dstalnov,Java,2008-08-02 14:28:28,,558,88,43,155,8,3                                                                                                \n" +
				"127,dstalnov,Java,2008-08-03 14:11:33,,373,82,22,188,53,20                                                                                              \n" +
				"128,Misko.Hevery,,2008-08-00 17:17:19,,0,0,0,0,0,0                                                                                                      \n" +
				"129,aeagle22206,,2008-08-02 10:50:34,,0,0,0,0,0,0                                                                                                       \n" +
				"130,aeagle22206,,2008-08-02 10:50:51,,0,0,0,0,0,0                                                                                                       \n" +
				"131,aeagle22206,,2008-08-02 10:54:29,,0,0,0,0,0,0                                                                                                       \n" +
				"132,aeagle22206,,2008-08-02 10:54:50,,0,0,0,0,0,0                                                                                                       \n" +
				"133,aeagle22206,,2008-08-02 10:56:31,,0,0,0,0,0,0                                                                                                       \n" +
				"134,Misko.Hevery,Java,2008-08-02 15:25:54,,45,4,2,29,0,0                                                                                                \n" +
				"135,Misko.Hevery,Java,2008-08-02 15:30:11,,0,0,3,0,0,0                                                                                                  \n" +
				"136,Misko.Hevery,Java,2008-08-02 16:56:39,,13,23,20,19,39,27                                                                                            \n" +
				"137,Misko.Hevery,Java,2008-08-02 16:59:43,,0,0,0,0,0,1                                                                                                  \n" +
				"138,dstalnov,Java,2008-08-03 01:35:30,,781,52,47,141,14,11                                                                                              \n" +
				"139,dstalnov,Java,2008-08-03 01:39:32,,0,20,0,0,0,0                                                                                                     \n" +
				"140,aeagle22206,Java,2008-08-02 14:31:16,,326,11,0,128,0,0                                                                                              \n" +
				"141,aeagle22206,Java,2008-09-05 13:14:05,,14,2,2,14,2,0                                                                                                 \n" +
				"142,jawolter,Java,2008-09-04 11:04:41,,1809,382,823,2999,873,1424                                                                                       \n" +
				"143,jawolter,Java,2008-09-00 00:35:56,,325,86,74,759,107,102                                                                                            \n" +
				"144,Misko.Hevery,Java,2008-09-03 09:53:49,,0,1,1,0,0,0                                                                                                  \n" +
				"145,Misko.Hevery,Java,2008-09-03 09:59:30,,8,0,1,0,0,0                                                                                                  \n" +
				"146,Misko.Hevery,Java,2008-09-03 10:29:31,,133,10,17,43,2,3                                                                                             \n" +
				"147,Misko.Hevery,Java,2008-09-03 10:58:19,,7,18,16,0,0,0                                                                                                \n" +
				"148,Misko.Hevery,Java,2008-09-03 11:20:48,,97,38,13,11,1,5                                                                                              \n" +
				"149,Misko.Hevery,Java,2008-09-03 13:16:26,,268,274,157,109,123,16                                                                                       \n" +
				"150,Misko.Hevery,Java,2008-09-03 13:32:07,,0,0,0,0,0,7                                                                                                  \n" +
				"151,Misko.Hevery,Java,2008-09-03 15:10:00,,212,84,193,0,0,8                                                                                             \n" +
				"152,Misko.Hevery,,2008-09-01 10:14:33,,0,0,0,0,0,0                                                                                                      \n" +
				"153,markusclermont,Java,2008-09-02 10:09:41,,43,0,0,23,0,0                                                                                              \n" +
				"154,markusclermont,Java,2008-09-03 09:57:13,,28,2,3,20,2,3                                                                                              \n" +
				"155,Misko.Hevery,Java,2008-09-03 12:33:28,,56,0,3,34,0,1                                                                                                \n" +
				"156,Misko.Hevery,Java,2008-09-04 22:12:43,,0,0,0,0,330,15                                                                                               \n" +
				"157,Misko.Hevery,Java,2008-09-04 22:20:50,,0,0,0,0,137,0                                                                                                \n" +
				"158,Misko.Hevery,Java,2008-09-05 09:51:55,,162,24,60,73,4,14                                                                                            \n" +
				"159,Misko.Hevery,Java,2008-09-05 10:10:13,,0,0,0,32,0,0                                                                                                 \n" +
				"160,Misko.Hevery,Java,2008-09-05 15:46:47,,293,250,952,75,211,1185                                                                                      \n" +
				"161,jawolter,,2008-09-01 01:11:17,,0,0,0,0,0,0                                                                                                          \n" +
				"162,Misko.Hevery,Java,2008-09-01 19:29:43,,1767,497,1151,558,121,249                                                                                    \n" +
				"163,Misko.Hevery,Java,2008-09-01 20:28:11,,43,0,0,0,43,0                                                                                                \n" +
				"164,Misko.Hevery,Java,2008-09-03 09:42:30,,130,0,0,63,0,0                                                                                               \n" +
				"165,Misko.Hevery,Java,2008-09-03 09:45:11,,3,5,9,3,1,8                                                                                                  \n" +
				"166,Misko.Hevery,Java,2008-09-03 11:13:27,,576,111,271,343,5,184                                                                                        \n" +
				"167,Misko.Hevery,Java,2008-09-03 11:23:05,,8,0,1,0,0,0                                                                                                  \n" +
				"168,Misko.Hevery,,2008-09-04 18:37:40,,0,0,0,0,0,0                                                                                                      \n" +
				"169,Misko.Hevery,,2008-09-05 12:00:58,,0,0,0,0,0,0                                                                                                      \n" +
				"170,Misko.Hevery,Java,2008-10-06 18:37:33,,881,46,165,377,15,58                                                                                         \n" +
				"171,Misko.Hevery,Java,2008-10-06 18:48:00,,0,0,1,0,0,0                                                                                                  \n" +
				"172,Misko.Hevery,Java,2008-10-00 10:53:16,,158,14,20,301,14,45                                                                                          \n" +
				"173,Misko.Hevery,Java,2008-10-00 11:31:36,,170,81,69,219,131,118                                                                                        \n" +
				"174,Misko.Hevery,Java,2008-10-00 11:55:55,,0,0,0,2,0,0                                                                                                  \n" +
				"175,Misko.Hevery,Java,2008-10-00 15:21:32,,213,4,50,66,0,23                                                                                             \n" +
				"176,Misko.Hevery,,2008-10-00 15:41:06,,0,0,0,0,0,0                                                                                                      \n" +
				"177,Misko.Hevery,Java,2008-10-00 16:44:47,,179,220,123,13,7,7                                                                                           \n" +
				"178,Misko.Hevery,Java,2008-10-00 16:47:20,,0,0,1,0,0,0                                                                                                  \n" +
				"179,Misko.Hevery,,2008-10-00 16:49:19,,0,0,0,0,0,0                                                                                                      \n" +
				"180,Misko.Hevery,Java,2008-10-00 17:34:23,,84,61,22,10,60,13                                                                                            \n" +
				"181,Misko.Hevery,Java,2008-10-00 17:37:00,,0,0,0,0,4,1                                                                                                  \n" +
				"182,Misko.Hevery,Java,2008-10-00 17:38:19,,0,0,0,0,0,1                                                                                                  \n" +
				"183,Misko.Hevery,Java,2008-10-00 18:22:48,,317,55,180,58,8,31                                                                                           \n" +
				"184,jawolter,,2008-10-00 18:34:06,,0,0,0,0,0,0                                                                                                          \n" +
				"185,jawolter,,2008-10-00 18:36:31,,0,0,0,0,0,0                                                                                                          \n" +
				"186,jawolter,,2008-10-00 18:36:56,,0,0,0,0,0,0                                                                                                          \n" +
				"187,jawolter,Java,2008-10-00 18:38:15,,76,6,6,0,1,1                                                                                                     \n" +
				"188,Misko.Hevery,,2008-10-00 19:09:52,,0,0,0,0,0,0                                                                                                      \n" +
				"189,Misko.Hevery,,2008-10-00 19:15:15,,0,0,0,0,0,0                                                                                                      \n" +
				"190,Misko.Hevery,,2008-10-00 19:26:25,,0,0,0,0,0,0                                                                                                      \n" +
				"191,Misko.Hevery,,2008-10-00 22:07:19,,0,0,0,0,0,0                                                                                                      \n" +
				"192,dstalnov,Java,2008-10-01 11:09:18,,142,0,0,44,0,0                                                                                                   \n" +
				"193,Misko.Hevery,Java,2008-10-01 11:49:08,,149,1,48,17,0,9                                                                                              \n" +
				"194,Misko.Hevery,Java,2008-10-01 11:54:19,,7,0,6,4,0,4                                                                                                  \n" +
				"195,Misko.Hevery,Java,2008-10-01 13:56:27,,4,0,0,0,0,0                                                                                                  \n" +
				"196,Misko.Hevery,Java,2008-10-01 14:01:26,,6,0,3,0,0,0                                                                                                  \n" +
				"197,Misko.Hevery,Java,2008-10-01 15:04:42,,3,17,30,1,50,9                                                                                               \n" +
				"198,Misko.Hevery,,2008-10-01 15:08:21,,0,0,0,0,0,0                                                                                                      \n" +
				"199,Misko.Hevery,Java,2008-10-01 19:12:49,,20,0,9,1,0,4                                                                                                 \n" +
				"200,Misko.Hevery,Java,2008-10-01 19:24:44,,18,0,10,0,0,0                                                                                                \n" +
				"201,dstalnov,Java,2008-10-03 06:51:25,,409,0,59,103,0,13                                                                                                \n" +
				"202,Misko.Hevery,Java,2008-10-03 10:28:23,,0,0,0,77,0,0                                                                                                 \n" +
				"203,Misko.Hevery,Java,2008-10-03 11:59:59,,40,2,31,2,0,10                                                                                               \n" +
				"204,Misko.Hevery,Java,2008-10-03 16:09:39,,520,505,429,0,0,8                                                                                            \n" +
				"205,Misko.Hevery,Java,2008-10-03 16:12:49,,2,3,0,0,0,0                                                                                                  \n" +
				"206,Misko.Hevery,Java,2008-10-03 16:24:42,,0,0,10,0,0,0                                                                                                 \n" +
				"207,Misko.Hevery,Java,2008-10-03 16:35:04,,13,0,3,0,0,0                                                                                                 \n" +
				"208,Misko.Hevery,Java,2008-10-03 16:44:34,,0,0,21,0,0,0                                                                                                 \n" +
				"209,Misko.Hevery,Java,2008-10-03 16:46:52,,0,3,1,0,0,0                                                                                                  \n" +
				"210,Misko.Hevery,Java,2008-10-04 12:47:05,,2072,1822,694,1035,890,371                                                                                   \n" +
				"211,Misko.Hevery,Java,2008-10-04 20:27:20,,66,60,5,0,0,0                                                                                                \n" +
				"212,Misko.Hevery,Java,2008-10-04 20:32:58,,1,4,3,0,0,0                                                                                                  \n" +
				"213,dstalnov,Java,2008-10-05 01:42:56,,997,1303,2548,283,326,852                                                                                        \n" +
				"214,Misko.Hevery,Java,2008-10-06 13:19:31,,88,45,31,1,0,11                                                                                              \n" +
				"215,Misko.Hevery,Java,2008-10-06 13:44:29,,123,102,174,41,25,82                                                                                         \n" +
				"216,Misko.Hevery,Java,2008-10-06 14:22:45,,307,112,27,0,0,0                                                                                             \n" +
				"217,Misko.Hevery,Java,2008-10-06 15:41:37,,26,32,23,0,0,4                                                                                               \n" +
				"218,Misko.Hevery,Java,2008-10-06 21:59:12,,887,2074,1582,919,2204,1698                                                                                  \n" +
				"219,Misko.Hevery,Java,2008-10-00 08:32:10,,30,13,20,0,0,0                                                                                               \n" +
				"220,Misko.Hevery,Java,2008-10-00 08:59:29,,16,4,39,0,0,0                                                                                                \n" +
				"221,Misko.Hevery,Java,2008-10-00 09:10:03,,1,0,3,0,0,0                                                                                                  \n" +
				"222,Misko.Hevery,Java,2008-10-00 09:44:21,,0,4,27,0,0,10                                                                                                \n" +
				"223,Misko.Hevery,Java,2008-10-00 09:46:53,,0,4,1,0,0,0                                                                                                  \n" +
				"224,Misko.Hevery,Java,2008-10-00 10:16:26,,51,5,60,18,2,23                                                                                              \n" +
				"225,Misko.Hevery,Java,2008-10-01 11:01:48,,0,32,0,0,11,0                                                                                                \n" +
				"226,Misko.Hevery,Java,2008-10-01 15:10:13,,4,11,26,0,0,0                                                                                                \n" +
				"227,Misko.Hevery,Java,2008-10-01 15:39:51,,150,124,33,0,0,7                                                                                             \n" +
				"228,Misko.Hevery,Java,2008-10-01 15:51:59,,35,16,37,0,0,0                                                                                               \n" +
				"229,Misko.Hevery,Java,2008-10-01 16:18:20,,75,22,108,123,15,190                                                                                         \n" +
				"230,Misko.Hevery,Java,2008-10-01 16:30:40,,0,0,5,0,0,0                                                                                                  \n" +
				"231,Misko.Hevery,Java,2008-10-01 16:37:36,,24,75,20,7,16,6                                                                                              \n" +
				"232,Misko.Hevery,Java,2008-10-01 16:42:41,,4,8,55,3,4,62                                                                                                \n" +
				"233,Misko.Hevery,Java,2008-10-01 17:09:39,,66,83,75,4,0,27                                                                                              \n" +
				"234,Misko.Hevery,Java,2008-10-01 17:29:24,,107,95,43,0,1,8                                                                                              \n" +
				"235,Misko.Hevery,Java,2008-10-01 21:13:14,,217,88,136,2,0,14                                                                                            \n" +
				"236,Misko.Hevery,Java,2008-10-01 21:20:40,,18,2,43,28,3,71                                                                                              \n" ;


		
	}
}