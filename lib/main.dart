import 'package:flutter/material.dart';
import '/dummy_data.dart';
import '/screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import '/screens/meal_detail.dart';
import './screens/categories_meals_screen.dart';
import './screens/categories_screen.dart';
import '../models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static Color lightAccent = Color(0xff5563ff);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String , bool >_filters ={
    'gluten' : false,
    'lactose' : false,
    'vegan': false,
    'vegetarian' : false,

  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  void _setFilters(Map<String, bool> filterData){
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] = true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Meals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: MyApp.lightAccent,
        canvasColor: Color.fromRGBO(255, 255, 255, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 16,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FilterScreen.routeName : (ctx) => FilterScreen(_filters,_setFilters),
      },
      onGenerateRoute: (settings){
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx)=> CategoriesScreen());
      },
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx)=> CategoriesScreen());
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Meals'),
      ),
      body: Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}
