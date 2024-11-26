import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PowerFlex Curso',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.purple,
        scaffoldBackgroundColor: Colors.black, // Fundo preto
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              fontSize: 16,
              color: Colors.white), // Texto de corpo com cor escura
          bodyMedium: TextStyle(
              fontSize: 14,
              color: Colors.white), // Texto de corpo com cor escura
          titleLarge: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white), // Títulos brancos e negrito
        ),
      ),
      home: CourseDetailScreen(),
    );
  }
}

class CourseDetailScreen extends StatelessWidget {
  final Course course = Course(
    name: 'Musculação',
    description:
        'A musculação é ideal para fortalecer os músculos, melhorar a postura, aumentar a densidade óssea e ajudar no emagrecimento. Indicada para todos os níveis de experiência.',
    availableTimes: ['06:00 AM', '10:00 AM', '04:00 PM', '08:00 PM'],
    benefits: [
      'Fortalecimento muscular',
      'Melhora na postura',
      'Aumento da densidade óssea',
      'Auxílio no emagrecimento',
      'Prevenção de lesões',
    ],
  );

  CourseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple,
        title: Text(course.name, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header estilizado
            CourseHeader(course: course),
            const SizedBox(height: 20),

            // Descrição do curso
            SectionContainer(
              title: 'Sobre o Curso',
              content: course.description,
            ),
            const SizedBox(height: 20),

            // Benefícios do curso
            SectionContainer(
              title: 'Benefícios da Musculação',
              child: Column(
                children: course.benefits.map((benefit) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle, color: Colors.purple),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Text(benefit,
                              style: Theme.of(context).textTheme.bodyMedium)),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // Lista de horários disponíveis
            SectionContainer(
              title: 'Horários Disponíveis',
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: course.availableTimes.length,
                separatorBuilder: (_, __) =>
                    Divider(color: Colors.grey[300], height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading:
                        const Icon(Icons.access_time, color: Colors.purple),
                    title: Text(
                      course.availableTimes[index],
                      style: const TextStyle(
                          color: Colors.white), // Cor da fonte em branco
                    ),
                    dense: true,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Rodapé
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class CourseHeader extends StatelessWidget {
  final Course course;

  const CourseHeader({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Gradiente estilizado
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.fitness_center,
              color: Colors.white,
              size: 80,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(course.name, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 5),
        const Text('PowerFlex Academy',
            style: TextStyle(color: Colors.purple, fontSize: 18)),
      ],
    );
  }
}

class SectionContainer extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? child;

  const SectionContainer(
      {super.key, required this.title, this.content, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[800], // Alterando o fundo para cinza mais escuro
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 20, color: Colors.purple),
          ),
          const SizedBox(height: 10),
          if (content != null)
            Text(content!, style: Theme.of(context).textTheme.bodyLarge),
          if (child != null) child!,
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.purple,
      ),
      child: const Center(
        child: Column(
          children: [
            Text(
              'PowerFlex Academy',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Transformando vidas através do movimento.',
              style: TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Icon(Icons.fitness_center, color: Colors.white, size: 28),
          ],
        ),
      ),
    );
  }
}

class Course {
  final String name;
  final String description;
  final List<String> availableTimes;
  final List<String> benefits;

  Course({
    required this.name,
    required this.description,
    required this.availableTimes,
    required this.benefits,
  });
}
