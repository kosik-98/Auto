import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("AppDelegate: приложение запущено")
        // Здесь можно добавить инициализацию Firebase, Push Notifications и т. д.
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Приостановка задач, отключение таймеров
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Сохранение данных пользователя
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Обновление интерфейса или данных
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Возобновление приостановленных задач
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Финальная очистка
    }
}
