import { useEffect, useState } from 'react'
import { Badge } from '@/components/ui/badge'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'

type Health = { status: string; database: string }

function StatusRow({ label, value, testId }: { label: string; value: string; testId: string }) {
  return (
    <div className="flex items-center justify-between">
      <span className="text-sm text-muted-foreground">{label}</span>
      <Badge data-testid={testId} variant={value === 'ok' ? 'default' : 'destructive'}>
        {value}
      </Badge>
    </div>
  )
}

function App() {
  const [health, setHealth] = useState<Health | null>(null)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    fetch('/api/health')
      .then(async (response) => {
        const body = (await response.json()) as Health
        setHealth(body)
      })
      .catch((reason: unknown) => {
        setError(String(reason))
      })
  }, [])

  return (
    <main className="flex min-h-svh items-center justify-center p-6">
      <Card className="w-full max-w-sm">
        <CardHeader>
          <CardTitle>Radar health</CardTitle>
          <CardDescription>API and database status</CardDescription>
        </CardHeader>
        <CardContent className="flex flex-col gap-3">
          {error && (
            <Badge role="alert" variant="destructive">
              Error: {error}
            </Badge>
          )}
          {health && (
            <>
              <StatusRow label="API" value={health.status} testId="api-status" />
              <StatusRow label="Database" value={health.database} testId="db-status" />
            </>
          )}
          {!health && !error && <Badge variant="outline">Loading…</Badge>}
        </CardContent>
      </Card>
    </main>
  )
}

export default App
