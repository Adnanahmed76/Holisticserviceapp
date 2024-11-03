import 'package:flutter/material.dart';
import 'package:mynewearth/models/offering_model.dart';
import 'package:mynewearth/provider.dart';
import 'package:provider/provider.dart';
class AddEditOfferingScreen extends StatefulWidget {
  final OfferingModel? offering;
  final int? index;
  const AddEditOfferingScreen({super.key, this.offering, this.index});

  @override
  State<AddEditOfferingScreen> createState() => _AddEditOfferingScreenState();
}

class _AddEditOfferingScreenState extends State<AddEditOfferingScreen> {
 final _formKey=GlobalKey<FormState>();
 late TextEditingController practitionerNameController;
 late TextEditingController titleController;
 late TextEditingController descriptionController;
 late TextEditingController durationController;
 late TextEditingController priceController;
 String category="Spiritual";
 String type="In-Person";

 @override
  void initState() {
    
    super.initState();
    practitionerNameController=TextEditingController(text: widget.offering?.practitionerName ?? "");
    titleController=TextEditingController(text: widget.offering?.title ?? "");
    descriptionController=TextEditingController(text: widget.offering?.description ?? "");
    durationController=TextEditingController(text: widget.offering?.duration.toString());
    priceController=TextEditingController(text: (widget.offering?.price ?? 0).toString());
    category=widget.offering?.category ?? "Spiritual";
    type=widget.offering?.type ?? "In -person";

  }

  @override
  void dispose() {
    practitionerNameController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    durationController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text(widget.offering==null? 'Add offering' : 'Edit offering '),),
body: SingleChildScrollView(
  child: Padding(padding: const EdgeInsets.all(16),
child: Card(

  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller:practitionerNameController,
            decoration: InputDecoration(labelText: "Practitioner Name"),
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(labelText: "Title"),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: "Description",
              alignLabelWithHint: true,
            ),
            maxLines: 4,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.multiline,
          ),
          DropdownButtonFormField(
            value: category,
            items: ["Spiritual","Mental","Emotional"].map((cat)=>DropdownMenuItem(value: cat,child: Text(cat),)).toList(),
            onChanged: (value)=>setState(() =>category=value as String),
            decoration: InputDecoration(labelText: "category"),
          ),
          DropdownButtonFormField(
            value: durationController.text.isEmpty ? "30 min" : durationController.text,
            items: ["30 min", "1 hr", "1.5 hr", "2 hr"].map((duration) => 
              DropdownMenuItem(value: duration, child: Text(duration))
            ).toList(),
            onChanged: (value) => setState(() => durationController.text = value.toString()),
            decoration: InputDecoration(labelText: "Duration"),
          ),

          Row(
            children: [
              Expanded(child: RadioListTile(value: "In-Person", groupValue: type, onChanged: (value)=>setState(()=>type = value.toString()),title: Text("In Person"),)),
              Expanded(child: RadioListTile(value: "Online", groupValue: type, onChanged: (value)=>setState(() =>type=value.toString()),title: Text("Online"),))
            ],
          ),
          TextFormField(
            controller: priceController,
            decoration: InputDecoration(
              labelText: "Price"
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 2,
              ),
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  final newOffering=OfferingModel(
                    practitionerName:practitionerNameController.text,
                    title:titleController.text,
                    description:descriptionController.text,
                    category:category,
                    duration:durationController.text,
                    price: priceController.text.isEmpty ? 0.0 : double.parse(priceController.text),
                    type: type,
                  );
                  if(widget.index==null){
                    Provider.of<OfferingProvider>(context,listen: false).addOffering(newOffering);
                  }else{
                    Provider.of<OfferingProvider>(context,listen:false).updateoffering(widget.index!,newOffering);
                  }
                  Navigator.pop(context);
                }
              }, 
              child: Text(
                widget.offering==null ? "Add" : "Edit",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
)
),
)
    );
  }
}