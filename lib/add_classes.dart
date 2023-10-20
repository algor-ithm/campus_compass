import 'package:campus_compass/test_data.dart';
import 'package:flutter/material.dart';

class AddClassSchedule extends StatefulWidget {
  const AddClassSchedule({super.key});

  final String title = "Class Schedule";

  @override
  State<AddClassSchedule> createState() => _AddClassScheduleState();
}

class _AddClassScheduleState extends State<AddClassSchedule> {
  Course? _selectedCourse;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // has two properties - body and appBar
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 0, 73, 144), // color of body of scaffold
        title: Text(widget.title),
        actions: <Widget>[
          Row(
            children: [
              InkWell(
                // our + button
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Icon(Icons.edit),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  height: kToolbarHeight,
                  child: Image.asset(
                    'assets/images/SHSU_Primary_Logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
           const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
            ), // Existing centered content
          ),
          Align(
            // New aligned icon
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  print("dummyCourses data: $dummyCourses");
                  print('Unique Course Numbers: ${extractUniqueCourseNumbers(dummyCourses)}');
                  print('Unique Course Names: ${extractUniqueCourseNames(dummyCourses)}');
                  print('Unique Professor Names: ${extractUniqueProfessorNames(dummyCourses)}');
                  print('Unique Buildings: ${extractUniqueBuildings(dummyCourses)}');
                  print('Unique Room Numbers: ${extractUniqueRoomNumbers(dummyCourses)}');

                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Add a Class', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                AutoCompleteFormField(label: 'Course Number', options: extractUniqueCourseNumbers(dummyCourses)),
                                AutoCompleteFormField(label: 'Course Name', options: extractUniqueCourseNames(dummyCourses)),
                                AutoCompleteFormField(label: 'Professor Name', options: extractUniqueProfessorNames(dummyCourses)),
                                AutoCompleteFormField(label: 'Building Number', options: extractUniqueBuildings(dummyCourses)),
                                AutoCompleteFormField(label: 'Room Number', options: extractUniqueRoomNumbers(dummyCourses)),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // close the dialog
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // close the dialog
                                      },
                                      child: const Text('Add Class'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Image.asset(
                  'assets/images/paw_thick.png',
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

  // used to work with our test data
class Course {
  final String courseNumber;
  final String className;
  final String professorName;
  final String building;
  final String roomNumber;

  Course({
    required this.courseNumber,
    required this.className,
    required this.professorName,
    required this.building,
    required this.roomNumber,
  });
}

List<String> extractUniqueCourseNumbers(List<Course> courses){
  return courses.map((course) => course.courseNumber).toSet().toList();
}
List<String> extractUniqueCourseNames(List<Course> courses){
  return courses.map((course) => course.className).toSet().toList();
}
List<String> extractUniqueProfessorNames(List<Course> courses){
  return courses.map((course) => course.professorName).toSet().toList();
}
List<String> extractUniqueBuildings(List<Course> courses){
  return courses.map((course) => course.building).toSet().toList();
}
List<String> extractUniqueRoomNumbers(List<Course> courses){
  return courses.map((course) => course.roomNumber).toSet().toList();
}

class AutoCompleteFormField extends StatelessWidget {
  final String label;
  final List<String> options;
  final Function(String)? onOptionSelected;

  const AutoCompleteFormField({
    required this.label,
    required this.options,
    this.onOptionSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const <String>[];
        }
        return options.where((option) =>
            option.toLowerCase().contains(textEditingValue.text.toLowerCase())
        ).toList();
      },
      onSelected: (String selection) {
        if(onOptionSelected != null){
          onOptionSelected!(selection);
        }
        print('You just selected $selection');
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
    );
  }
}



// AutoCompleteFormField function from the login adapted to autocomplete fields for course input
/*Widget AutoCompleteFormField({
  required String label, // label of the input field 
  required List<String> options, // list of string options for the autocomplete funcitonality 
  TextEditingController? textEditingController, // allows the caller to provide a text controller to capture and control the input
  bool obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text( // displays the label of the input field
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) { // filters the list of autocomplete options based on user input
          print("User Input: ${textEditingValue.text}");
          print("Available options: $options");
          return options;
        },
        onSelected: (String selection) { // called when a user selects an autocomplete suggestion
          if (textEditingController != null){ 
            textEditingController.text = selection;
          }
        },
          fieldViewBuilder: (
            BuildContext context, 
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
              return TextField(
                controller: textEditingController,
                obscureText: obscureText,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical:  0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide:  BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)
                  ),
                ),
                onSubmitted:  (String value){
                  onFieldSubmitted();
                },
              );
            },
          ),
          const SizedBox(
            height: 30,
      ),
    ],
  );
}*/
