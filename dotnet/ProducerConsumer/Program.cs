
namespace ProducerConsumer
{
    class Program
    {
        static void Main(string[] args)
        {
            System.Console.BackgroundColor = System.ConsoleColor.White;
            var prodcons = new PCBasico(productors: 5, consumidores: 3);
            prodcons.Start();

            System.Console.ReadKey();
        }
    }
}
