import '../models/config-object.model.dart';
import '../models/selected-schema.model.dart';

class GetSelectedSchema {
  final Set<String> keys;
  final Set<Schema> schemas;

  const GetSelectedSchema({required this.keys, required this.schemas});

  SelectedSchemaModel call() {
    var selectedKey;
    var selectedSchema;

    
    for (var key in keys) {
      for (var schema in schemas) {
        if (key.toUpperCase() == schema.sufix.toUpperCase()) {
          selectedSchema = schema;
          selectedKey = schema.sufix;
        }
      }
    }

    

    return SelectedSchemaModel(selectedKey, selectedSchema);
  }
}
