
namespace ProducerConsumer
{
    class Program
    {
        static void Main(string[] args)
        {
            System.Console.BackgroundColor = System.ConsoleColor.White;
            var prodcons = new PCBasico(productors: 3, consumidores: 1);
            prodcons.Start();

            System.Console.ReadKey();
        }
    }
}
