import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfil do Usuário',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String fullName = "João da Silva";
  final String email = "joao.silva@example.com";

  final List<Map<String, dynamic>> workouts = [
    {
      "name": "Musculação",
      "description": "Treino para fortalecimento muscular.",
      "exercises": ["Supino", "Agachamento", "Rosca Direta"],
      "completed": false,
      "icon": Icons.fitness_center,
    },
    {
      "name": "Yoga",
      "description": "Posturas e meditações para relaxamento.",
      "exercises": [
        "Saudação ao Sol",
        "Postura da Árvore",
        "Cachorro Olhando para Baixo"
      ],
      "completed": false,
      "icon": Icons.self_improvement,
    },
    {
      "name": "Corrida",
      "description": "Corrida para condicionamento cardiovascular.",
      "exercises": ["Alongamento", "Corrida Leve", "Corrida Intensa"],
      "completed": false,
      "icon": Icons.directions_run,
    },
  ];

  double get progress {
    int completedWorkouts =
        workouts.where((workout) => workout['completed']).length;
    return completedWorkouts / workouts.length;
  }

  void completeWorkout(int index) {
    setState(() {
      workouts[index]['completed'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Powerflex'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Progresso nos Treinos:',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.grey[700],
                color: Colors.purple,
              ),
              const SizedBox(height: 8),
              Text(
                '${(progress * 100).toStringAsFixed(0)}% concluído',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Treinos Disponíveis:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Divider(color: Colors.white),
              Column(
                children: workouts.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> workout = entry.value;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 5,
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(
                        workout['icon'],
                        size: 40,
                        color: Colors.purple,
                      ),
                      title: Text(
                        workout['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        workout['description'],
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: workout['completed']
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WorkoutDetailsPage(
                                      workout: workout,
                                      onComplete: () => completeWorkout(index),
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Ver'),
                            ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutDetailsPage extends StatelessWidget {
  final Map<String, dynamic> workout;
  final VoidCallback onComplete;

  const WorkoutDetailsPage({
    super.key,
    required this.workout,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              workout['description'],
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 20),
            const Text(
              'Exercícios:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: workout['exercises'].length,
                itemBuilder: (context, index) {
                  String exercise = workout['exercises'][index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.purple,
                      ),
                      title: Text(
                        exercise,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                onComplete();
                Navigator.pop(context);
              },
              child: const Text('Marcar como Concluído'),
            ),
          ],
        ),
      ),
    );
  }
}
