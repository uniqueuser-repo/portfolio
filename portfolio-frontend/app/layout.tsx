import './globals.scss'
import { Inter } from 'next/font/google'

const inter = Inter({ subsets: ['latin'] })

export const metadata = {
  title: 'Andrew Orlowski',
  description: 'Andrew Orlowski\'s website. Andrew Orlowski is a Software Engineer and ex-professional VALORANT player. Andrew Orlowski was born in 1999.',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={inter.className}>{children}</body>
    </html>
  )
}
