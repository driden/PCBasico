using System;
using System.Threading;


namespace ProducerConsumer
{
    internal class PCBasico
    {
        const int BufferSize = 10;
        int[] buffer = new int[BufferSize];
        int pai, pae, cantProd, cantCons, cant = 0;
        SemaphoreSlim esUsado = new SemaphoreSlim(1);
        SemaphoreSlim estaLleno = new SemaphoreSlim(BufferSize);
        SemaphoreSlim estaVacio = new SemaphoreSlim(0);
        Random rnd = new Random();

        public PCBasico(int productors, int consumidores)
        {
            cantProd = productors;
            cantCons = consumidores;
        }

        void Producir()
        {
            while (true)
            {
                estaLleno.Wait();
                esUsado.Wait();

                int num = rnd.Next(20);
                Verde("Productor {0} , Inserta {1} en el buffer.", Thread.CurrentThread.ManagedThreadId, num);
                buffer[pai] = num;
                pai = (pai + 1) % BufferSize;

                esUsado.Release();
                estaVacio.Release();
            }
        }

        void Consumir()
        {
            while (true)
            {
                estaVacio.Wait();
                esUsado.Wait();

                int num = buffer[pae];
                pae = (pae + 1) % BufferSize;

                Rojo("Consumidor {0}, Extrae {1} del buffer.", Thread.CurrentThread.ManagedThreadId, num);
                cant--;
                Thread.Sleep(rnd.Next(1000));
                esUsado.Release();
                estaLleno.Release();


            }
        }

        public void Start()
        {
            LargarProductores();
            LargarConsumidores();
        }

        void LargarProductores()
        {
            for (int i = 0; i < cantProd; i++)
            {
                new Thread(new ThreadStart(Producir)).Start();
            }
        }
        void LargarConsumidores()
        {
            for (int i = 0; i < cantCons; i++)
            {
                new Thread(new ThreadStart(Consumir)).Start();
            }
        }
        void Rojo(string texto, params object[] args)
        {
            lock (this)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine(texto, args);
                Console.ForegroundColor = ConsoleColor.Black;
            }
        }
        void Verde(string texto, params object[] args)
        {
            lock (this)
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine(texto, args);
                Console.ForegroundColor = ConsoleColor.Black;
            }
        }
    }
}
