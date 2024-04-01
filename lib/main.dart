import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twenty8',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(background: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const MyHomePage(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/inbox': (context) => const InboxScreen(),
        '/profile': (context) => const UserProfile(),
        '/addProperty': (context) => const AddPropertyScreen(),
        '/admin': (context) => const AdminPanel(),
        '/index': (context) => const UserPanel(),
        '/search': (context) => const Search(),
        '/lublin': (context) => const Lublin(),
        '/warsaw': (context) => const Warsaw(),
        '/krakow': (context) => const Krakow(),
        '/poland': (context) => const Poland(),
        '/propertyDetails': (context) => const PropertyDetailsScreen(),
        '/properties': (context) => const CategoryScreen(category: 'Properties'),
        '/rentals': (context) => const RentalsCategoryScreen(category: 'Rentals'),
        '/Freelance': (context) => const FreelanceCategoryScreen(category: 'Freelance'),
        '/services': (context) => const ServicesCategoryScreen(category: 'Services'),
        '/general': (context) => const OthersCategoryScreen(category: 'Others'),
        '/settings': (context) => const SettingsScreen(),
        '/alreadyMember': (context) => const LoginScreen(), // Added route for already member
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Twenty8'),
        actions: [
          const LanguageSelector(),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20), // Added spacing
          SearchSection(),
          const SizedBox(height: 20), // Added spacing
          BrowseByLocationSection(),
          Expanded(
            child: PropertyListingsSection(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarSection(),
    );
  }
}

class SearchSection extends StatelessWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '  Search by name, type, number',
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        Navigator.pushNamed(context, '/search');
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}

class BrowseByLocationSection extends StatelessWidget {
  const BrowseByLocationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Browse by Location:',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(width: 10),
          _buildClickableCityLink(context, 'Lublin', '/lublin'),
          const SizedBox(width: 10),
          _buildClickableCityLink(context, 'Warsaw', '/warsaw'),
          const SizedBox(width: 10),
          _buildClickableCityLink(context, 'Krakow', '/krakow'),
          const SizedBox(width: 10),
          _buildClickableCityLink(context, 'Others', '/poland'), // Assuming 'Others' corresponds to 'Poland'
        ],
      ),
    );
  }

  Widget _buildClickableCityLink(BuildContext context, String cityName, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        cityName,
        style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
      ),
    );
  }
}

class PropertyListingsSection extends StatelessWidget {
  const PropertyListingsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Explore',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPropertyListing(context, 'Homes', Icons.home_work, '/properties', Colors.blue), // Default color: Blue
                _buildPropertyListing(context, 'Rentals', Icons.calendar_today_outlined, '/rentals', Colors.green), // Changed icon color to green
                _buildPropertyListing(context, 'Freelance', Icons.work_outline, '/Freelance', Colors.red), // Changed icon color to red
                _buildPropertyListing(context, 'Others', Icons.travel_explore, '/general', Colors.orange), // Changed icon color to orange
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyListing(BuildContext context, String title, IconData icon, String route, MaterialColor black) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          IconButton(
            icon: Icon(icon),
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
            iconSize: 64,
            color: Colors.black,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavigationBarSection extends StatelessWidget {
  const BottomNavigationBarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Set type to fixed
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Column(
            children: <Widget>[
              Icon(Icons.home, color: Colors.black), // Change icon color to black
              Text('Home', style: TextStyle(color: Colors.black)), // Add text under icon
            ],
          ),
          label: '', // Set label to empty string
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: <Widget>[
              Icon(Icons.search, color: Colors.black), // Change icon color to black
              Text('Search', style: TextStyle(color: Colors.black)), // Add text under icon
            ],
          ),
          label: '', // Set label to empty string
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: <Widget>[
              Icon(Icons.email, color: Colors.black), // Change icon color to black
              Text('Inbox', style: TextStyle(color: Colors.black)), // Add text under icon
            ],
          ),
          label: '', // Set label to empty string
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: <Widget>[
              Icon(Icons.work_outline, color: Colors.black), // Change icon color to black
              Text('Freelance', style: TextStyle(color: Colors.black)), // Add text under icon
            ],
          ),
          label: '', // Set label to empty string
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: <Widget>[
              Icon(Icons.account_circle, color: Colors.black), // Change icon color to black
              Text('Profile', style: TextStyle(color: Colors.black)), // Add text under icon
            ],
          ),
          label: '', // Set label to empty string
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            Navigator.pushNamed(context, '/search');
            break;
          case 2:
            Navigator.pushNamed(context, '/inbox');
            break;
          case 3:
            Navigator.pushNamed(context, '/Freelance');
            break;
          case 4:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
    );
  }
}


class LanguageSelector extends StatefulWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String _selectedLanguage = 'English'; // Default language is English

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0),
      child: Material(
        color: Colors.transparent,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedLanguage,
            onChanged: (String? newValue) {
              setState(() {
                _selectedLanguage = newValue!;
                // Implement language change logic here
              });
            },
            items: <String>['English', 'Polish', 'Ukrainian']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 12.0),
                ),
              );
            }).toList(),
            icon: const Icon(Icons.language, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLoginForm(context),
            const SizedBox(height: 8), // Additional space between form and additional text
            _buildSignUpText(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        ),
        width: MediaQuery.of(context).size.width * 0.4, // Set width to match register form
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.grey[200],
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.grey[200],
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Add your login logic here
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Not a member yet? '),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: const Text(
              'Sign up',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.none, // Removing underline
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSignUpForm(context),
            const SizedBox(height: 8), // Additional space between form and additional text
            _buildAlreadyMemberText(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpForm(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'First Name',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: const OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Re-enter Password',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: const OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // Add your sign up logic here
                },
                child: const Text('Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlreadyMemberText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already a member? '),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.none, // Removing underline
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
      ),
      body: const Center(
        child: Text('Inbox Screen'),
      ),
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: const Center(
        child: Text('User Profile Screen'),
      ),
    );
  }
}

class AddPropertyScreen extends StatelessWidget {
  const AddPropertyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Property'),
      ),
      body: const Center(
        child: Text('Add Property Screen'),
      ),
    );
  }
}

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: const Center(
        child: Text('Admin Panel Screen'),
      ),
    );
  }
}

class UserPanel extends StatelessWidget {
  const UserPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Panel'),
      ),
      body: const Center(
        child: Text('User Panel Screen'),
      ),
    );
  }
}

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: const Center(
        child: Text('Search Screen'),
      ),
    );
  }
}

class Lublin extends StatelessWidget {
  const Lublin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lublin'),
      ),
      body: const Center(
        child: Text('Lublin Screen'),
      ),
    );
  }
}

class Warsaw extends StatelessWidget {
  const Warsaw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warsaw'),
      ),
      body: const Center(
        child: Text('Warsaw Screen'),
      ),
    );
  }
}

class Krakow extends StatelessWidget {
  const Krakow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Krakow'),
      ),
      body: const Center(
        child: Text('Krakow Screen'),
      ),
    );
  }
}

class Poland extends StatelessWidget {
  const Poland({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poland'),
      ),
      body: const Center(
        child: Text('Poland Screen'),
      ),
    );
  }
}

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Property Details'),
      ),
      body: const Center(
        child: Text('Property Details Screen'),
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({Key? key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Center(
        child: Text('$category Screen'),
      ),
    );
  }
}

class RentalsCategoryScreen extends StatelessWidget {
  final String category;

  const RentalsCategoryScreen({Key? key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Center(
        child: Text('$category Screen'),
      ),
    );
  }
}

class FreelanceCategoryScreen extends StatelessWidget {
  final String category;

  const FreelanceCategoryScreen({Key? key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Center(
        child: Text('$category Screen'),
      ),
    );
  }
}

class ServicesCategoryScreen extends StatelessWidget {
  final String category;

  const ServicesCategoryScreen({Key? key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Center(
        child: Text('$category Screen'),
      ),
    );
  }
}

class OthersCategoryScreen extends StatelessWidget {
  final String category;

  const OthersCategoryScreen({Key? key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Center(
        child: Text('$category Screen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}