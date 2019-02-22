import Foundation
import RealmSwift

class PersistData {
    
    static func writeToRealm(snacks: [Snack]) {

        let realm = try! Realm()

        for snack in snacks {
            try! realm.write {
                
                realm.add(snack)
            }
        }

    }
    
    static func retrieveFromRealm() -> [Snack]{
        var snacks: [Snack] = []
        
        let realm = try! Realm()
        let results = realm.objects(Snack.self)
        
        for result in results {
            snacks.append(result)
        }
        
        return snacks
    }
}
