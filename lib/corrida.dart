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
    name: 'Corrida',
    description:
        'A corrida é uma excelente prática para melhorar o condicionamento físico, aumentar a resistência e fortalecer a saúde cardiovascular. Ideal para iniciantes e corredores experientes, com acompanhamento profissional.',
    availableTimes: ['06:00 AM', '08:00 AM', '05:00 PM', '07:00 PM'],
    benefits: [
      'Melhora da saúde cardiovascular',
      'Aumento da resistência física',
      'Redução do estresse',
      'Fortalecimento muscular',
      'Queima de calorias e controle de peso',
    ],
  );

  CourseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple, // AppBar roxo
        title: Text(
          course.name,
          style: const TextStyle(
            color: Colors.white, // Texto branco no AppBar
            fontWeight: FontWeight.bold,
          ),
        ),
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
              color: Colors.grey[800], // Caixa cinza
            ),
            const SizedBox(height: 20),

            // Benefícios do curso
            SectionContainer(
              title: 'Benefícios da Corrida',
              color: Colors.grey[800],
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
              ), // Caixa cinza
            ),
            const SizedBox(height: 20),

            // Lista de horários disponíveis
            SectionContainer(
              title: 'Horários Disponíveis',
              color: Colors.grey[800],
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
                    title: Text(course.availableTimes[index],
                        style: Theme.of(context).textTheme.bodyMedium),
                    dense: true,
                  );
                },
              ), // Caixa cinza
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
              Icons.directions_run,
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
  final Color? color; // Adicionando cor personalizada

  const SectionContainer(
      {super.key, required this.title, this.content, this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color ?? Colors.white, // Usando a cor cinza personalizada
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
        color: Colors.purple, // Rodapé roxo
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
            Icon(Icons.directions_run, color: Colors.white, size: 28),
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
